Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5745E3FA580
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhH1LcC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Aug 2021 07:32:02 -0400
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:52394 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234247AbhH1LcB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Aug 2021 07:32:01 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Aug 2021 07:32:01 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 64A901807DC1D
        for <linux-tip-commits@vger.kernel.org>; Sat, 28 Aug 2021 11:22:34 +0000 (UTC)
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id BC7011809579F;
        Sat, 28 Aug 2021 11:22:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id C87962EBFAA;
        Sat, 28 Aug 2021 11:22:25 +0000 (UTC)
Message-ID: <d18d2c6fd87f552def3210930da34fd276b4fd6d.camel@perches.com>
Subject: Re: [tip: efi/core] efi: cper: fix scnprintf() use in
 cper_mem_err_location()
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org
Date:   Sat, 28 Aug 2021 04:22:24 -0700
In-Reply-To: <163014706409.25758.9928933953235257712.tip-bot2@tip-bot2>
References: <163014706409.25758.9928933953235257712.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.21
X-Stat-Signature: 7uetgy9b5emkj3oiuubiwcgypyi8eaa9
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C87962EBFAA
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18pUxn2alZBBCM1l+xnT4V9kNXDsxRmRQs=
X-HE-Tag: 1630149745-356633
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, 2021-08-28 at 10:37 +0000, tip-bot2 for Rasmus Villemoes wrote:
> The following commit has been merged into the efi/core branch of tip:
[]
> efi: cper: fix scnprintf() use in cper_mem_err_location()
> 
> The last two if-clauses fail to update n, so whatever they might have
> written at &msg[n] would be cut off by the final nul-termination.
> 
> That nul-termination is redundant; scnprintf(), just like snprintf(),
> guarantees a nul-terminated output buffer, provided the buffer size is
> positive.
> 
> And there's no need to discount one byte from the initial buffer;
> vsnprintf() expects to be given the full buffer size - it's not going
> to write the nul-terminator one beyond the given (buffer, size) pair.
[]
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
[]
> @@ -221,7 +221,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>  		return 0;
>  
> 
>  	n = 0;
> -	len = CPER_REC_LEN - 1;
> +	len = CPER_REC_LEN;
>  	if (mem->validation_bits & CPER_MEM_VALID_NODE)
>  		n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
>  	if (mem->validation_bits & CPER_MEM_VALID_CARD)

[etc...]

Is this always single threaded?

It doesn't seem this is safe for reentry as the output buffer
being written into is a single static

static char rcd_decode_str[CPER_REC_LEN];


