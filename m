Return-Path: <linux-tip-commits+bounces-6783-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70840BCE9C0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Oct 2025 23:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60F3A4E1A99
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Oct 2025 21:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251FA26B76C;
	Fri, 10 Oct 2025 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KVIxqDZG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28F237A4F;
	Fri, 10 Oct 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131405; cv=none; b=f1LrI9C4oZ2XmkKenA1PtCqZsDQI+budOaqd7/OFQM7DFCVZIg5Z8ESepg06v341Vr1QX+AVCjoaEKf57hfrZEI0s4srtGj7/0s/FGOMehQ4nnhhfP0YKp3IUCIR07+aIAWE3Sw6SWRIUTpSL2JHNbCgU46C8yBmZuCpzCNbVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131405; c=relaxed/simple;
	bh=Nkr3uJp5OqnDjljCPLtTh4RSl6GNhT46w1+67dI/zNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6q7GRB/D5dSL85n/iIR+9l53wKIyNHoz0EOZQ7vafwy5g8u1yS1Oyw+j5CyZxTa+zQe+4pVzCGIRiS7NWD7EZkdo+MH5pTPa2HNXiz7LNdUa6LohG1GpxHpEh9fTVvaYlRXbmfXLRrL3R2AXA4SiyovoPRMsX+/6UZeFwXQdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KVIxqDZG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 39E2040E016D;
	Fri, 10 Oct 2025 21:23:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I8IXORZg4TQ6; Fri, 10 Oct 2025 21:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760131387; bh=qySDLascQ+yEC/QoOhS2+2VgA0BDmGIVzu4wiCJpGlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVIxqDZGlLlU7IW1hC0/qbB10VYeoGJ6k9FwRMRCBHgy32I2rVKesuC3q3VlysSG8
	 d6v9vEyxBl7QwhFNe/VkdZC4dtZSYffraJi9Dk69dVw5arCFpWHLDCGsMcp4nN2DMG
	 2AHkfg+X7uMe2vXJ+Mnj/YKcX8CgjuetqZ9v7qcqWJJF/UurWt4JF8/Qo/OuuDLbh2
	 jK+dSL0DCicwiJiQ8/n8Ss7rUgLzUo0pUFq6/sg/zl9m7qJaYq71bKHkN8xgLymylQ
	 NV8rWwmRCWmcbHiNwCWV4iypocXzhztDCaX4rzzc5cVAd2lNAc8/1Q6SwBqhD4NZT9
	 wDeHtoW+IFmDS7ZGRj5PEmAyNNdS5fdptvfkwHhXtljs4xnrEkq/8MeoeztSsDTi2b
	 RCRt6gG8HzcxHA1825eJtXUMuKU7UkaO6OOQp7yHwB0QhsXwUcXIIuua0Qv4Y304Pt
	 bcJQ/4HC5t409TPu1Xuy4oET+UzfTecWK6JABXiCAJe3uRBMeVGLDUIQdvNlYQy6wY
	 frcXYJ9suYF+/C7YgJRbNn/u3bTvT12+kktaYPElvg30bD0lIcP2ObGE7eEuU2Iom2
	 fVHgnSXsUK20YxCbrRiLblvYQ662rTXOyQP/i5Zc8zM7yFlW0Kd5sT8FIm8vuWOvet
	 JeHDo9M3HdDGo5FQlg//LbTY=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7F39240E015F;
	Fri, 10 Oct 2025 21:23:01 +0000 (UTC)
Date: Fri, 10 Oct 2025 23:22:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org
Subject: Re: [tip: x86/cleanups] crypto: X86 - Remove CONFIG_AS_VAES
Message-ID: <20251010212251.GAaOl5K1M2UOdqNzYP@fat_crate.local>
References: <20250819085855.333380-2-ubizjak@gmail.com>
 <175577973263.1420.12918884895191770948.tip-bot2@tip-bot2>
 <20251010202122.GA2922@quark>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010202122.GA2922@quark>

On Fri, Oct 10, 2025 at 01:21:22PM -0700, Eric Biggers wrote:
> On Thu, Aug 21, 2025 at 12:35:31PM -0000, tip-bot2 for Uros Bizjak wrote:
> > The following commit has been merged into the x86/cleanups branch of tip:
> > 
> > Commit-ID:     4593311290006793a38a9cbd91d4a65b63cd7b76
> > Gitweb:        https://git.kernel.org/tip/4593311290006793a38a9cbd91d4a65b63cd7b76
> > Author:        Uros Bizjak <ubizjak@gmail.com>
> > AuthorDate:    Tue, 19 Aug 2025 10:57:50 +02:00
> > Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > CommitterDate: Thu, 21 Aug 2025 12:23:28 +02:00
> > 
> > crypto: X86 - Remove CONFIG_AS_VAES
> 
> Hi!  Just wanted to confirm that this is going to make it into an x86
> pull request for 6.18?

Bah, looks like one of us went on vacation after sending a bunch of pull
requests expecting the others to send that one. Oh well, it hasn't happened.

Thanks for letting me know, I'll send them tomorrow.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

