Return-Path: <linux-tip-commits+bounces-5159-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C85AA6CE6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 10:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271D27A46E1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C322A819;
	Fri,  2 May 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u7QyzeB7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8922A4F1;
	Fri,  2 May 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175799; cv=none; b=Z+y8VCpsM+/n6iB9Br5niXgn7iuQUYjiyM14263Fit+C69Bn6NXNxdSzHwGIIjn2imWHZVljBFarR4Rce7y8euiIrEoSUgr192jxuU6PgfTTMYXAObvY7XbV8D6edRYw/c9SElmkLIVhe2Wi3V5H2kDF0M2g/MstDnLB36m6sSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175799; c=relaxed/simple;
	bh=/RIHaS4NyUQQQxjQHFXWDvTVPnEdyMnbBligI3FDoBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+9I+ckT7NpVEIRBAgLuAHavXW7itSaH0CZhuE2g+W2uGzOHcWU9grImVVgNhusl8AYfP/pcLhGAffKupUiOuvopihCixFb6CB3fdWzBM7YsL65wpiEy8aDi9d2IPeWAnGNPNLjqAt6QpkAmU26G8h51KTOUPIdRGk1JjNvodJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u7QyzeB7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/RIHaS4NyUQQQxjQHFXWDvTVPnEdyMnbBligI3FDoBY=; b=u7QyzeB7TVJNCTciytPo75z74P
	WQtTb70VEpejxT7DVcvOg6ZZOdu6n02EpKo6V7uLwUhwktxLMMft13Bv35EI7Bp3HL+PRu3hR0rR1
	UTjboJVNv7RCfbqx9F6DCUTOH7+Vn8fQtz9h6PfpFF/rJOLBHOH+eLzry3JP/GaNQsQgPPhaifVXd
	qZvZWuN7PKe1qMxaas3Lpckh8vWUsOa5EY2zirXz4/x9vlBuh9DKGguelIB+MogyFTlu0pRYZwWHb
	v3iZLc2EH9JvIvKWi6gCQswYItaRisDb3JX6dIuFQLkBZqYU0PBo1rmikHgT0cxvT28wz5SjlasLl
	lV/4w/jg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAm4g-0000000B7ur-3a56;
	Fri, 02 May 2025 08:48:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F40F3001D4; Fri,  2 May 2025 10:48:45 +0200 (CEST)
Date: Fri, 2 May 2025 10:48:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Prundeanu, Cristian" <cpru@amazon.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Blake, Geoff" <blakgeof@amazon.com>,
	"Csoma, Csaba" <csabac@amazon.com>,
	"Doebel, Bjoern" <doebel@amazon.de>,
	Gautham Shenoy <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: EEVDF regression still exists
Message-ID: <20250502084844.GT4198@noisy.programming.kicks-ass.net>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
 <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
 <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
 <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>

On Thu, May 01, 2025 at 04:16:07PM +0000, Prundeanu, Cristian wrote:

> (Please keep in mind that the target isn't to get SCHED_BATCH to the same
> level as 6.5-default; it's to resolve the regression from 6.5-default to
> 6.6+ default, and from 6.5-SCHED_BATCH to 6.6+ SCHED_BATCH).

No, the target definitely is not to make 6.6+ default match 6.5 default.

The target very much is getting you performance similar to the 6.5
default that you were happy with with knobs we can live with.

