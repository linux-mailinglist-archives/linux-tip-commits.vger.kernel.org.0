Return-Path: <linux-tip-commits+bounces-6945-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE219BE4618
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 17:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF4F54E35CA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC42E54B3;
	Thu, 16 Oct 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9qgMB13"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEF212566;
	Thu, 16 Oct 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630194; cv=none; b=tPCYCcIH+Ne1Fb5t40aEl1VQHWdnZpL2ROi4snBpFggXu3FR4FC2IFoiBrY1HnaIakk5h1fD5606eCJADRhr605CuOMQJQmTvX4dirm00zIHWKBzM39qlp18VdvFkq/IXXeOOMQWOfUq0wV4+OML6bR7oaupOMFb1H0X9RSmhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630194; c=relaxed/simple;
	bh=7J3mPyENrGUlXA7yZTXeYzgwf+inJngs5n5bTexBVXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyuFuU3LgkTvqUry7G+2s8B9XqB4ph/fik3v2ZzAjpWPh2baktwZWfUie52ulvOW8rHv5NnUycg5xfNim00FLcaG2znb0aUosp9BPpEFrGsz4h/0GjB/yAffLQ5SZu34bQADxFA3LLgk8ohuUVofp54VjHouqX42RTtfAT7apHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9qgMB13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AFCC4CEF1;
	Thu, 16 Oct 2025 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630194;
	bh=7J3mPyENrGUlXA7yZTXeYzgwf+inJngs5n5bTexBVXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9qgMB13VEnNwjl7EvA+dUgxyZwb2I4J4GgJ9nG/1ycwqkN32YffG/k2+5ICDR3LZ
	 dCu1F3ZgzcZq9z96GHL0mELFPsrpYjqVgdxqcB0u4jUQqPxgZH4L1CtY+YY8KZYpyW
	 uGGAHyxMur//cSRazS+TdB70EhjZFMMJo1T+g1Y2O7QzyCsfisv16TUjeY48ttMti3
	 Def3cM5sIaHTSHwK3JSo+9sFVcggrbU4CGYhBiwm7k5FhNOZ92JouSCITWmdodUeDp
	 JzWXqiAOVhVcBbB5tiF+T9poiRPXNh/fcTluH7CIPtFGlCInUf+o2snbmSlhQVluO9
	 Pl1/cT8kUcnvA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v9QLE-000000007Qy-0TfP;
	Thu, 16 Oct 2025 17:56:36 +0200
Date: Thu, 16 Oct 2025 17:56:36 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	x86@kernel.org
Subject: Re: [tip: irq/drivers] irqchip: Pass platform device to platform
 drivers
Message-ID: <aPEVtDo1CHibAGxn@hovoldconsulting.com>
References: <20251013094611.11745-12-johan@kernel.org>
 <176062960151.709179.10135307807179758941.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176062960151.709179.10135307807179758941.tip-bot2@tip-bot2>

On Thu, Oct 16, 2025 at 03:46:41PM -0000, tip-bot2 for Johan Hovold wrote:
> The following commit has been merged into the irq/drivers branch of tip:
> 
> Commit-ID:     9a1926893b68931e2d1dbadec9435a7efef92d76
> Gitweb:        https://git.kernel.org/tip/9a1926893b68931e2d1dbadec9435a7efef92d76
> Author:        Johan Hovold <johan@kernel.org>
> AuthorDate:    Mon, 13 Oct 2025 11:46:11 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Thu, 16 Oct 2025 17:26:34 +02:00
> 
> irqchip: Pass platform device to platform drivers

> diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
> index 41df168..2370ab6 100644
> --- a/drivers/irqchip/irq-imx-mu-msi.c
> +++ b/drivers/irqchip/irq-imx-mu-msi.c
> @@ -296,10 +296,9 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
>  		  },
>  };
>  
> -static int imx_mu_of_init(struct device_node *dn, struct device_node *parent,
> -			  const struct imx_mu_dcfg *cfg)
> +static int imx_mu_of_probe(struct platform_device *pdev, struct device_node *parent,
> +			   const struct imx_mu_dcfg *cfg)

There's still an editing mistake here; the new name should just be
'imx_mu_probe'.

Johan

