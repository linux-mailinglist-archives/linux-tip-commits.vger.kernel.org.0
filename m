Return-Path: <linux-tip-commits+bounces-4795-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F6A8272C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 16:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09863A7A94
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251C265629;
	Wed,  9 Apr 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q7JuOWiq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E1264FA5;
	Wed,  9 Apr 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207631; cv=none; b=L0kpsGOL4cmsrBmslDgX8IQjtvIEUYAJBaZzFT3vjaKQm5ETD8E8x8mahwPxpBmI5ebuhwTdR33aibwVz/a0BmncpIgNfpFHoGRV8/8iLET91bC9BSCZ+Bs7eBmUYEXExQEtO3bPNZE3Kdjq4NNhbaKeK7/9aomDBIbsIoaRjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207631; c=relaxed/simple;
	bh=UgktLFzb+e+eJV8h1xhP+4y4L19Zt2j1W5TFzLZ3fAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqG5KAYvYdL7EUovdutqz4bs00+MTb0jIZqBFu8CyD/ihmlyOD77b5IRZJuuJNgKnStP25AbtRBkNoKzSJLnbkitwAqp3r4LmpobLrQTs+CsoB3/V9U5LcavwQ9Ok3AjOqVNDx/eu/BOcL9dStiqAWjMSpV9qADyBevO2nBIH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q7JuOWiq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Ro2fPi/15BsTrXL3Ti3RuIwgl6WKvf6SctPhYlhK8k=; b=q7JuOWiqNBR44LFThNc7ttAMJA
	dqNFuO3RvQssM9X5n3aWR6EV7Y5ue9p2Yg79PwTq6LxMN98dZMpvSKVqib9omN94DtUk3hgZajiXc
	OItud1HbcwWnIvviDf1AvjOD5pcEEC6i3F2nCiwxwKC2ZmlmbnLVwLq0ZvE6ugE+jYl6iloVBbjba
	P9H/U1ScMwugRgj91aiKazNHeH/keaHYvLK6d8+HRtnH8LdwVxFY05d7qQU+APvzEIrc9qDODUQ3t
	Y8pruiEOPJSq7uSl1CLn1gnNmfG8hphtHv33WlWK9xcY4bNMBj7i3jd5YeJ91eljLTh0sKseX4ify
	S/dXoX8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2W52-00000001YbP-05FQ;
	Wed, 09 Apr 2025 14:07:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A4F33003FA; Wed,  9 Apr 2025 16:07:03 +0200 (CEST)
Date: Wed, 9 Apr 2025 16:07:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: Re: [tip: perf/core] uprobes/x86: Add support to emulate NOP5
 instruction
Message-ID: <20250409140703.GB9833@noisy.programming.kicks-ass.net>
References: <20250408211310.51491-1-jolsa@kernel.org>
 <174419899905.31282.16125441491898382603.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174419899905.31282.16125441491898382603.tip-bot2@tip-bot2>

On Wed, Apr 09, 2025 at 11:43:19AM -0000, tip-bot2 for Jiri Olsa wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     38440aebd4acc7bb3721eea77829bdb724d2551a
> Gitweb:        https://git.kernel.org/tip/38440aebd4acc7bb3721eea77829bdb724d2551a
> Author:        Jiri Olsa <jolsa@kernel.org>
> AuthorDate:    Tue, 08 Apr 2025 23:13:09 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 09 Apr 2025 12:35:17 +02:00
> 
> uprobes/x86: Add support to emulate NOP5 instruction
> 
> Adding support to emulate NOP5 as the original uprobe instruction.
> 
> This change speeds up uprobe on top of NOP5 and is a preparation for
> usdt probe optimization, that will be done on top of NOP5 instruction.
> 
> With this change the usdt probe on top of NOP5 won't take the performance
> hit compared to usdt probe on top of standard NOP instruction.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Link: https://lore.kernel.org/r/20250408211310.51491-1-jolsa@kernel.org
> ---
>  arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 9194695..63cc68e 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -608,6 +608,16 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  		*sr = utask->autask.saved_scratch_register;
>  	}
>  }
> +
> +static int is_nop5_insn(uprobe_opcode_t *insn)
> +{
> +	return !memcmp(insn, x86_nops[5], 5);
> +}
> +
> +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> +{
> +	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
> +}
>  #else /* 32-bit: */
>  /*
>   * No RIP-relative addressing on 32-bit
> @@ -621,6 +631,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  {
>  }
> +static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_X86_64 */
>  
>  struct uprobe_xol_ops {
> @@ -852,6 +866,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  		break;
>  
>  	case 0x0f:
> +		if (emulate_nop5_insn(auprobe))
> +			goto setup;
>  		if (insn->opcode.nbytes != 2)
>  			return -ENOSYS;
>  		/*

This is still very weird code. See the comment here:

https://lkml.kernel.org/r/20241213104536.GZ35539@noisy.programming.kicks-ass.net

