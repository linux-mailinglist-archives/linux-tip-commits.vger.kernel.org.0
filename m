Return-Path: <linux-tip-commits+bounces-458-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607385A7F0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Feb 2024 16:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05293B21BE7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Feb 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D403B786;
	Mon, 19 Feb 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmA4Fkqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F703B190;
	Mon, 19 Feb 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358221; cv=none; b=fb+2a6nNhnxmeNKv1WwRkWjlDdmDf9nZe00SpMk8TIztpFxLvPF1HTxXVREtnTSGasIOffW7ay8vRfzkG5GFfx1nPybJtWmFpoZWBRNdTzpGmd9FTdCM+oMUsvNRE+gLDHxjv2S0ZoV6PYWktDKHR3rGsHKLRO1s8ypgSaXyveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358221; c=relaxed/simple;
	bh=ViZrw86k4pjLburJCJObXL4Filt6Xa7zhElSH1BTaM0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gjr9Z55hlhetF0hs4UFYIxJBco7F0k+6i/IUJ9Q27RMUwnmtEk8atX9kIlScjlnvjP/AkY1EAH/d0x5JDd8sB1nXc3Ug/82wE0YSOfGPRr+VWWjWCqqSPo+XpfbPKAzlRHgEVAwgSFAqqdL7ygacInIWL7Eim41oWAszh3Jx+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmA4Fkqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C44C433C7;
	Mon, 19 Feb 2024 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708358221;
	bh=ViZrw86k4pjLburJCJObXL4Filt6Xa7zhElSH1BTaM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CmA4FkqprLlsrbkkuP++2cothZ3a2rLe1RDDzOzZYJGbUE+vzvqi7vXc2/azCPQfl
	 H6LWYYmIqhUz8Xqr9Pf6aIs0Sbe7O12kVDFZXSwLZgBXTK6ND9OJ35iHSNPBCwsYB3
	 q8zcTlVFze53LFrQa8Ho/pY+9vKgPTU7TBF922DnU7pVOovbSAzk2wxMYds55LMIeq
	 UJxpIITaZwAz5vSAZm8JftfLF8FyRafSXO51hh6Khdddud68eiVqkIAsMREth4449L
	 MDcQFLIL09Ep8+rcMhnXRnNLXv9kp+TLIAqWknmQ9E8Xr6CCbcvu55lv1nVVl8D/wW
	 yjExMpDKAkcdw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rc60o-004cv5-LP;
	Mon, 19 Feb 2024 15:56:58 +0000
Date: Mon, 19 Feb 2024 15:56:58 +0000
Message-ID: <867cj04fcl.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: tip-bot2@linutronix.de,
	apatel@ventanamicro.com,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	tglx@linutronix.de,
	geert@linux-m68k.org,
	linux-renesas-soc@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: irq/msi] genirq/irqdomain: Remove the param count restriction from select()
In-Reply-To: <170802702416.398.14922976721740218856.tip-bot2@tip-bot2>
References: <170802702416.398.14922976721740218856.tip-bot2@tip-bot2>
	<20240127161753.114685-3-apatel@ventanamicro.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: biju.das.jz@bp.renesas.com, tip-bot2@linutronix.de, apatel@ventanamicro.com, linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, tglx@linutronix.de, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, x86@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 19 Feb 2024 15:50:36 +0000,
Biju Das <biju.das.jz@bp.renesas.com> wrote:
> 
> > Now that the GIC-v3 callback can handle invocation with a fwspec parameter
> > count of 0 lift the restriction in the core code and invoke select()
> > unconditionally when the domain provides it.
> 
> This patch breaks on RZ/G2L SMARC EVK as of_phandle_args_to_fwspec count()
> is called after irq_find_matching_fwspec() is causing fwspec->param_count=0
> and this results in boot failure as the patch removes the check.
> 
> Maybe we need to revert this patch or fix the fundamental issue.
> 
> Cheers,
> Biju
> ---
>  kernel/irq/irqdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 0bdef4f..8fee379 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -448,7 +448,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
>  	 */
>  	mutex_lock(&irq_domain_mutex);
>  	list_for_each_entry(h, &irq_domain_list, link) {
> -		if (h->ops->select && fwspec->param_count)
> +		if (h->ops->select)
>  			rc = h->ops->select(h, fwspec, bus_token);
>  		else if (h->ops->match)
>  			rc = h->ops->match(h, to_of_node(fwnode), bus_token);
> 
> 

Dmitry posted his take on this at [1], and I have suggested another
possible fix in my reply.

Could you please give both patches a go?

Thanks,

	M.

[1] https://lore.kernel.org/r/20240219-gic-fix-child-domain-v1-1-09f8fd2d9a8f@linaro.org

-- 
Without deviation from the norm, progress is not possible.

