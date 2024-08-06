Return-Path: <linux-tip-commits+bounces-1957-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D63949565
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C05DB2AA08
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B41BD01F;
	Tue,  6 Aug 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H9lmYuDt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635B17ADFF;
	Tue,  6 Aug 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959967; cv=none; b=MWlV7nqQCdEqRyBa7Ug7j/u/LZBXWlZYzpIuZ61wFWQatfEcSs5lNlr2DNmvYL5oUheXMGHSajxdQxBI+gIjmC9Pc8onjyZX12Seuo3RoxE1IY0/d//bn2c+WtOdG+W+a40wIu8TEKMPBFXUh8hNTY1vGreUnifcmXQvuETnfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959967; c=relaxed/simple;
	bh=L094s6dgTaebJvx8KMepgKJZkbwvcTRRO/8s5ZjJseI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxrQoYQ+2+yku67xMs52XI6bRuJ1HmtO1uosxQmj1Wc5BhEKh8d2QwSCDQt7qaE3/wfKMnW6/T9TypSCNdUPDoXHN5oFhcDYuwzOi/CeBmbV9CACgqx51tzLvNqFFthfdqbrDcnY5tXH42akIl1AS0+7Zv8YuzHio7aUTzMSzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H9lmYuDt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hW8PwegrEtyoCH/LRwr2suT3lUYho3hue0Xw0g/ULhw=; b=H9lmYuDtpXJWauU64QKSk5OTmy
	mi83Hezc1VdfeBDj1j9mFZbhHndxZH8EbKX7UAFqeTJ09qzMLcPSUbcBukggYeMwZuFD9e2i69rnQ
	iwly453Uk0zK6muE0dW49Z/JVYrb3JnMNq0VVaMDG63pTHWyM5fbTM6q42Y0yti6zn4WhKvSAmlax
	Kr3A7jSbWQGk9Oe1/x6r15l1IzOjaWG73cQHstB9qZe/ELmkly1Ra9mUgBy58YBArcenEVIT9bnyL
	bOUvObvGXKrgrhjBdYNYelAwpTba7ptK8LdT/rXLYQ1hNRXCmMd01fGFWki+DVOl7Ia6OPrKvhCCz
	wWJ22mkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbMap-00000006UIw-1tuG;
	Tue, 06 Aug 2024 15:59:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9654730066A; Tue,  6 Aug 2024 17:59:22 +0200 (CEST)
Date: Tue, 6 Aug 2024 17:59:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Message-ID: <20240806155922.GH12673@noisy.programming.kicks-ass.net>
References: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
 <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>
 <20240806085050.GQ37996@noisy.programming.kicks-ass.net>
 <d99175bb-b5ca-46e6-a781-df4d21e9b7a8@roeck-us.net>
 <20240806145632.GR39708@noisy.programming.kicks-ass.net>
 <20240806150515.GS39708@noisy.programming.kicks-ass.net>
 <20240806154653.GT39708@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806154653.GT39708@noisy.programming.kicks-ass.net>

On Tue, Aug 06, 2024 at 05:46:53PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 06, 2024 at 05:05:15PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 06, 2024 at 04:56:32PM +0200, Peter Zijlstra wrote:
> > > On Tue, Aug 06, 2024 at 07:25:42AM -0700, Guenter Roeck wrote:
> > > 
> > > > I created http://server.roeck-us.net/qemu/x86-v6.11-rc2/ with all
> > > > the relevant information. Please let me know if you need anything else.
> > > 
> > > So I grabbed that config, stuck it in the build dir I used last time and
> > > upgraded gcc-13 from 13.2 ro 13.3. But alas, my build runs successfully
> > > :/
> > > 
> > > Is there anything else special I missed?
> > 
> > run.sh is not exacrlty the same this time, different CPU model, that
> > made it go.
> > 
> > OK, lemme poke at this.
> 
> Urgh, so crypto's late_initcall() does user-mode-helper based modprobe
> looking for algorithms before we kick off /bin/init :/
> 
> This makes things difficult.
> 
> Urgh.

So the problem is that mark_readonly() splits a code PMD due to NX. Then
the second pti_clone_entry_text() finds a kernel PTE but a user PMD
mapping for the same address (from the early clone) and gets upset.

And we can't run mark_readonly() sooner, because initcall expect stuff
to be RW. But initcalls do modprobe, which runs user crap before we're
done initializing everything.

This is a right mess, and I really don't know what to do.

