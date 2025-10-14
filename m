Return-Path: <linux-tip-commits+bounces-6812-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5482CBD9FEB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D5C543785
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D127F13D503;
	Tue, 14 Oct 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bSYh00nQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12915347C7;
	Tue, 14 Oct 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452164; cv=none; b=mUdKAMHeUoXL+rRGPTmg1L2Ac2kDiIqxFm7W3NPJNlQBp2nHkrisIUXtwDMgMBFb2BGaFbY99uQKs/BGlfwOKHKRlxnwMwgrc4NhUyR5us/yXcOqtvsvmfFVEZoASC0OT5JC5bNgrqLkApl1UT2EWRWhLlNB9enUXiMmXRkPueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452164; c=relaxed/simple;
	bh=QvjWfHjGO2sF3MFV6FvokMkK5N15CNLHITiNvMHAfBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNjo5eBd3a55bex2v9IK/eAPwXef4bpbugpaYahkTWTGi93iqY0rl709cCnFgVIAM/3qWsC0GSayhmbSuDgG4rqFlo14ouEONOkmvOvBOSP3ikwjL1zGlPBFiyOuMJ/8oTsH2+mF2XPgU6E4HI60mKJ3B8CslyEkQNpfKTTtZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bSYh00nQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0F71E40E01AB;
	Tue, 14 Oct 2025 14:29:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5DpOWjy5mgf0; Tue, 14 Oct 2025 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760452157; bh=15an4VsKunty+dfVO+3n4tiRBFc4Fhhr9BErv61vZMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSYh00nQTaGihDnaiTW7yOhEgaiJ9fraTiQBDYFRH7hxnMbF4yBhXTWpwL9wcKRsl
	 HzCPh1zmEOqivszfSuDyJ1wer1zDcFH0xI67qwg0dsvXgTb2miJSFGsOzFHTmRn92m
	 UsHQeeNl2R72vBcaIWaBIVAlXbHu5gu9zTMfJsmmo3uZXSxfLK/NafcPEOjuLlhTBB
	 I0mB7UHTWCZwN/BdiR3lRvqkcvrHP/mcZ3XOk4IncLqBMedgfDd9GLBNeBOkYCLr3T
	 b/mfc/Y7oxrQipOUFGc6S59HFIzntH6ZoKIqf4CVUN9opyGqsElbMn5rzDZVQftMxe
	 DQzQfP//vwTQJEoRYOecKIgG/IKh5BvXoAdMNlB6by6SCDVIPzSJ5QD1t8UecIo//b
	 g84JsPLUC0Y6BsXrDH9sCH8RamkADtKBfekfQqlfY8H1jYaB6X7uxph7fLm00NrwyY
	 PEiSQb5lYslmN7hQW/Ie2/PAil4W/JuoB+tOoKL3AhY0uvqiAG7vxB63plin2klY97
	 I/6fSOo/DSfrBFfqmlF0qUbPmGogD9FQ/nL34ATVmrYpLbrA86N/uR1vZqsTw2ujls
	 T5LLV0yIZBbmO9DsfrTgqa7s4RvVxO3B1BD6S+uJjbIn78PXwIOgwJ4zvrfZ0bxaSQ
	 1/dGBeFUY2Tohztt76eQvCwA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id AE9A140E019F;
	Tue, 14 Oct 2025 14:29:12 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:29:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
Message-ID: <20251014142911.GGaO5eN9A675vu0i3f@fat_crate.local>
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <20251014132544.GBaO5PWEbKfbQFCXdB@fat_crate.local>
 <ddb38d36-0194-414c-8614-1f37b1f38283@suse.com>
 <20251014141856.GA3245006@noisy.programming.kicks-ass.net>
 <ff687fb4-56b3-49ee-bf9e-7bf5442cc64b@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff687fb4-56b3-49ee-bf9e-7bf5442cc64b@suse.com>

On Tue, Oct 14, 2025 at 04:26:07PM +0200, Juergen Gross wrote:
> I'm not sure the "x86/alternative: Refactor apply_alternatives()"
> patch will stay the way it is now. Maybe better to remove it, too.

Ok, lemme zap it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

