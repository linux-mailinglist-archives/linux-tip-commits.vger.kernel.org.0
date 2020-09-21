Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2314E272AD2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Sep 2020 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgIUP4B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Sep 2020 11:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgIUP4B (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Sep 2020 11:56:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5DC061755;
        Mon, 21 Sep 2020 08:56:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07e300d04ad4772eb9dd3d.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:d04a:d477:2eb9:dd3d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64C2B1EC03CE;
        Mon, 21 Sep 2020 17:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600703759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mYlp3QXOc9MHktEVG8kmImHxYUpQiLAHdcsfxrlWjQ=;
        b=nI/Xtt6pXswMgkG+QfbeaKEpzOhcW9L7ZuGwtgan3jJ69k6uknNrxKrGYC05iziyFfKroE
        HM08a1lb+++bf0UNAAaph7wRJXfxLZqaTkt01+LuMu5qwbsO2mwtbVQkxI+lYsusUycwgN
        J2D1/FPcXfyXuIMX1eso8ZhC23+HlmM=
Date:   Mon, 21 Sep 2020 17:55:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: efi/core] efi: Support for MOK variable config table
Message-ID: <20200921155551.GA1470@zn.tnic>
References: <20200905013107.10457-2-lszubowi@redhat.com>
 <160041785494.15536.5659054027150173595.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <160041785494.15536.5659054027150173595.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 18, 2020 at 08:30:54AM -0000, tip-bot2 for Lenny Szubowicz wrote:
> +void __init efi_mokvar_table_init(void)
> +{
> +	efi_memory_desc_t md;
> +	u64 end_pa;
> +	void *va = NULL;
> +	size_t cur_offset = 0;
> +	size_t offset_limit;
> +	size_t map_size = 0;
> +	size_t map_size_needed = 0;
> +	size_t size;
> +	struct efi_mokvar_table_entry *mokvar_entry;
> +	int err = -EINVAL;
> +
> +	if (!efi_enabled(EFI_MEMMAP))
> +		return;
> +
> +	if (efi.mokvar_table == EFI_INVALID_TABLE_ADDR)
> +		return;
> +	/*
> +	 * The EFI MOK config table must fit within a single EFI memory
> +	 * descriptor range.
> +	 */
> +	err = efi_mem_desc_lookup(efi.mokvar_table, &md);
> +	if (err) {
> +		pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
> +		return;
> +	}
> +	end_pa = efi_mem_desc_end(&md);
> +	if (efi.mokvar_table >= end_pa) {
> +		pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
> +		return;
> +	}
> +	offset_limit = end_pa - efi.mokvar_table;
> +	/*
> +	 * Validate the MOK config table. Since there is no table header
> +	 * from which we could get the total size of the MOK config table,
> +	 * we compute the total size as we validate each variably sized
> +	 * entry, remapping as necessary.
> +	 */
> +	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
> +		mokvar_entry = va + cur_offset;
> +		map_size_needed = cur_offset + sizeof(*mokvar_entry);
> +		if (map_size_needed > map_size) {
> +			if (va)
> +				early_memunmap(va, map_size);
> +			/*
> +			 * Map a little more than the fixed size entry
> +			 * header, anticipating some data. It's safe to
> +			 * do so as long as we stay within current memory
> +			 * descriptor.
> +			 */
> +			map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
> +				       offset_limit);

i386 allmodconfig build gives here:

In file included from ./arch/x86/include/asm/percpu.h:27:0,
                 from ./arch/x86/include/asm/current.h:6,
                 from ./arch/x86/include/asm/processor.h:17,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:65,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:73,
                 from ./include/linux/efi.h:17,
                 from drivers/firmware/efi/mokvar-table.c:35:
drivers/firmware/efi/mokvar-table.c: In function ‘efi_mokvar_table_init’:
./include/linux/kernel.h:850:29: warning: comparison of distinct pointer types lacks a cast
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                             ^
./include/linux/kernel.h:864:4: note: in expansion of macro ‘__typecheck’
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
./include/linux/kernel.h:874:24: note: in expansion of macro ‘__safe_cmp’
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
./include/linux/kernel.h:883:19: note: in expansion of macro ‘__careful_cmp’
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/firmware/efi/mokvar-table.c:149:15: note: in expansion of macro ‘min’
    map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
               ^~~

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
