Return-Path: <linux-tip-commits+bounces-4553-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE690A70D1F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20461669D5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8C1F3FE2;
	Tue, 25 Mar 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blfj1TAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B126A089;
	Tue, 25 Mar 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942576; cv=none; b=K1i9aoXZMR5uIGSUA+4yZxcWqyG/oCv33Cxa7lHQLxnpaCzMS82xEeC5Hzp82dUq8IGPQZKMeI55H87xMdZOOPPrXGpUqBuaWEXHQKEXmnP/x89DmejBpBEZqCCEuDbOEUqDv1oAoNUnoR1SNuLd8RVtBpooxk+cUjZNEa4wzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942576; c=relaxed/simple;
	bh=qMsdnC5BdorePBcvV5O9V9PD6cJMjNjgXGL+U81FnWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaycBQ8vJFeTrUwc9RJWVj20aEeyeaSzFFVYmjh3u/L8tU2BRpnuNKL9JwqoC+GY7iFW9+gWavTq1H/iN+x5vcxLfY9LdbE+9GMAMYHVCWJF6ww0nlgK6lNIRpaapfUUw16UeMfb+UtMr6GQo9XWf7xYmakkHi0t23RLpRD2Gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blfj1TAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0EEC4CEE4;
	Tue, 25 Mar 2025 22:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942575;
	bh=qMsdnC5BdorePBcvV5O9V9PD6cJMjNjgXGL+U81FnWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blfj1TAKajNS/onmvEdwv3mDPVhq+hZEKF268N4JLOmwDj66Kgo8NR7AHTJHEO4hy
	 BWeHMAl/sFQUlNzJ23eQdiyDJxdBJe2KcHp7UdOpLj3gB3FezlNwj2IVKrH76U2HTw
	 qy7W4L3amrF4tQZ/0zlNr/JVpo35vyzcgv+i3KoITVnT2esMqRrg7qj6ZufbhClLQl
	 RMnViWH8excgL9QUgSENkVPiQm72mT8nwBBOkkvRkap/I2Zprit4FSCuzYSkGCudbd
	 H4G4ShvsVBb92OUqOlfOEakOmTXgy8VfHa1hcxGhBwOLi1E0JBYJOmcpVrB1+8JqNW
	 Fp3J+GR0HBLJw==
Date: Wed, 26 Mar 2025 06:42:39 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, kernel
 test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, media: dib8000: Prevent
 divide-by-zero in dib8000_set_dds()
Message-ID: <20250326064239.5194fdc8@sal.lan>
In-Reply-To: <174294059839.14745.12160091729171456650.tip-bot2@tip-bot2>
References: <bd1d504d930ae3f073b1e071bcf62cae7708773c.1742852847.git.jpoimboe@kernel.org>
	<174294059839.14745.12160091729171456650.tip-bot2@tip-bot2>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 25 Mar 2025 22:09:58 -0000
"tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de> escreveu:

> The following commit has been merged into the objtool/urgent branch of tip:
> 
> Commit-ID:     e63d465f59011dede0a0f1d21718b59a64c3ff5c
> Gitweb:        https://git.kernel.org/tip/e63d465f59011dede0a0f1d21718b59a64c3ff5c
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Mon, 24 Mar 2025 14:56:06 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 25 Mar 2025 23:00:15 +01:00
> 
> objtool, media: dib8000: Prevent divide-by-zero in dib8000_set_dds()
> 
> If dib8000_set_dds()'s call to dib8000_read32() returns zero, the result
> is a divide-by-zero.  Prevent that from happening.
> 
> Fixes the following warning with an UBSAN kernel:
> 
>   drivers/media/dvb-frontends/dib8000.o: warning: objtool: dib8000_tune() falls through to next function dib8096p_cfg_DibRx()
> 
> Fixes: 173a64cb3fcf ("[media] dib8000: enhancement")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/bd1d504d930ae3f073b1e071bcf62cae7708773c.1742852847.git.jpoimboe@kernel.org
> Closes: https://lore.kernel.org/r/202503210602.fvH5DO1i-lkp@intel.com/
> ---
>  drivers/media/dvb-frontends/dib8000.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
> index 2f51659..cfe59c3 100644
> --- a/drivers/media/dvb-frontends/dib8000.c
> +++ b/drivers/media/dvb-frontends/dib8000.c
> @@ -2701,8 +2701,11 @@ static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
>  	u8 ratio;
>  
>  	if (state->revision == 0x8090) {
> +		u32 internal = dib8000_read32(state, 23) / 1000;
> +
>  		ratio = 4;
> -		unit_khz_dds_val = (1<<26) / (dib8000_read32(state, 23) / 1000);
> +
> +		unit_khz_dds_val = (1<<26) / (internal ?: 1);

This is theoretical, as in practice dib8096 won't likely be tuning
if reading this register would return zero, but at least for my
eyes, it would sound better to set unit_khz_dds_val to 1 internal
is zero, instead of 1<<26. 

>  		if (offset_khz < 0)
>  			dds = (1 << 26) - (abs_offset_khz * unit_khz_dds_val);
>  		else


Regards,
Mauro

