Return-Path: <linux-tip-commits+bounces-1956-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8470D9494C1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52331C2192A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7779821105;
	Tue,  6 Aug 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JKPMYar7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E618D63D;
	Tue,  6 Aug 2024 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959218; cv=none; b=m2CE1zwRpJ++MPqTUwmYUtqAEKpMDoWy/RLxhmGR6lXCTBglXf37wVNb/P7oGrwvSKDU9xSR+Mcu5ikQYB/YCmb1q9/HQdqAdSJfuxTCi9OExhd7Zew3NQFF0DN2GFu9cOWBQn028f/hB8aENeQsh6DTujtXJWbT67boQWgrTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959218; c=relaxed/simple;
	bh=4q0xi7Q+BHDBGBlVRg35bRaB2CVAEEDCb2A1kT2bW+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSXpqwb/2ISqBUo97aUU9M9YaY0PWjUcfgFs0kWw2rDv0+glYD5eXgj9HmIJEl138AQ8xg4w7NkLAa6/Ph8gtu5lug84nQcnUSqDua/H1a1SYwr6axjkzCiRYx8A8QOdo8gySPATU+9r5fxaq7xjDkKEHedAOpC6lCbZq4cfVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JKPMYar7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0gh9n8jsScUOfVltL1wP2ekmRS0C5pOHHxSH+T/Ugkk=; b=JKPMYar7GnfiOQHmW36Fn5R03y
	YFCs+hecENeiAhwhE7kzxW50ap9xPvY70kYeWbURMlAfVAENf4r4PN8m6q3j9j4GT6420SoYeXXF2
	lvWMHt9YSx2AS3leMWhQCbOv3n0bH26y0/3uJdx6wWpSEln9ZF0dUiwilGA773M1vL+RdfMQlQod+
	2tDiLlzg8yHWsvsCegsLJwRYU20Am1sXTMvOB2b9A4yeT1rWNF9WbUaRMkljvEmTeUXrariPvz3pj
	1MHR8b+hWCJLRpFQiv6WS7v/YNv3Nk+TwVrBgeLcBHSoLSwnHYm5zq+3ThH+DfLhQQTH4zCpc9Ak3
	EscDqcxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbMOk-00000005vHY-36hf;
	Tue, 06 Aug 2024 15:46:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ABFC430066A; Tue,  6 Aug 2024 17:46:53 +0200 (CEST)
Date: Tue, 6 Aug 2024 17:46:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Message-ID: <20240806154653.GT39708@noisy.programming.kicks-ass.net>
References: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
 <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>
 <20240806085050.GQ37996@noisy.programming.kicks-ass.net>
 <d99175bb-b5ca-46e6-a781-df4d21e9b7a8@roeck-us.net>
 <20240806145632.GR39708@noisy.programming.kicks-ass.net>
 <20240806150515.GS39708@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806150515.GS39708@noisy.programming.kicks-ass.net>

On Tue, Aug 06, 2024 at 05:05:15PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 06, 2024 at 04:56:32PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 06, 2024 at 07:25:42AM -0700, Guenter Roeck wrote:
> > 
> > > I created http://server.roeck-us.net/qemu/x86-v6.11-rc2/ with all
> > > the relevant information. Please let me know if you need anything else.
> > 
> > So I grabbed that config, stuck it in the build dir I used last time and
> > upgraded gcc-13 from 13.2 ro 13.3. But alas, my build runs successfully
> > :/
> > 
> > Is there anything else special I missed?
> 
> run.sh is not exacrlty the same this time, different CPU model, that
> made it go.
> 
> OK, lemme poke at this.

Urgh, so crypto's late_initcall() does user-mode-helper based modprobe
looking for algorithms before we kick off /bin/init :/

This makes things difficult.

Urgh.

