Return-Path: <linux-tip-commits+bounces-2689-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FC79B917C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EE41F22866
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44919CC04;
	Fri,  1 Nov 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CorQ444b"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC2487A7;
	Fri,  1 Nov 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466347; cv=none; b=TLttre3Iwlt/wCYbWvrZ5ySXzmXXijrwy8E0YRxfGNaTzhD6lKROIyRTw1esU7T7uXvnVgS4h34+0VFB1Dke2nKfgwvhbgS9KnFVQDjAJwQ2TstT5k+ivcmBgx48MWwg+u732+oP0nNKrJAcogZdGsETm93u7nZgruV5tg+DrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466347; c=relaxed/simple;
	bh=Nr3dp8vXJ0sLZgYMPhWAE2sX7ptpc5DvV4GyQ4AAt8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPsIE2fHDlPh1rULciYRQ7TSBBvdIXn0JPyelI/CJYhfUsVMj2MT9kef62lC5Nin8lTckBrG5X2sDPZxspCRnGDRVrzJHnwD6l/BnchTpBglSvOxdkW9WBmAdIkTN47o/KoPwWfO3miezr7jZB93U9hewiT4FAe/SYk0X7Tn2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CorQ444b; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wxNQLV+YRr0JXxilPc5fJ8f0DhP1zrWW8wgGA+gouV0=; b=CorQ444b6BCP+SEckN9Q696yRA
	xrqYlYbKeJZ6jsNKHc+i8mYvWT5i+lQh6/r3GNtARy0TXJ8sOQ/pAMoGBPJxSCI6AWYvNbjfYuk+1
	emgMwnFhnUBrBhWXWa+H2PjOeQmNrkPTcOozEE9LNiUMZP5dXZc4J+Vvd4XaU4DmYneNg2j+qwRAT
	HLdMYE4NNCQXCjcKGqrInJakV3GsKHFCRdJtVNhP2NSULL05843lOv6xwX08zRaFtVaMDmUkw6z1z
	vzd14Xx84ebVv0/I+QVT4t9UG6bzTJxm7TwDRtjzIUrGkqcMJK8I0eArM/RmnMY4JmINpGYUWgkaV
	jqdpgu5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6rLJ-0000000AgVs-0r8r;
	Fri, 01 Nov 2024 13:05:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 952F1300599; Fri,  1 Nov 2024 14:05:31 +0100 (CET)
Date: Fri, 1 Nov 2024 14:05:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Cristian Prundeanu <cpru@amazon.com>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjoern Doebel <doebel@amazon.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Geoff Blake <blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>,
	Csaba Csoma <csabac@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
Message-ID: <20241101130531.GW9767@noisy.programming.kicks-ass.net>
References: <ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com>
 <20241029045749.37257-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029045749.37257-1-cpru@amazon.com>

On Mon, Oct 28, 2024 at 11:57:49PM -0500, Cristian Prundeanu wrote:

> My testing with SCHED_BATCH is meanwhile concluded. It did reduce the 
> regression to less than half - but only with WAKEUP_PREEMPTION enabled. 
> When using NO_WAKEUP_PREEMPTION, there was no performance change compared 
> to SCHED_OTHER.

Because BATCH affects wakeup-preemption, and if there isn't any ever, it
makes no difference.

A BATCH task will not preempt another BATCH task, the only thing driving
preemption is slice exhaustion -- and we can now set slice per task to
match with the 'work' cycle.

> (At the risk of stating the obvious, using SCHED_BATCH only to get back to 
> the default CFS performance is still only a workaround,

It is not really -- it is impossible to schedule all the various
workloads without them telling us what they really like. The quest is to
find interfaces that make sense and are implementable. But fundamentally
tasks will have to start telling us what they need. We've long since ran
out of crystal balls.

