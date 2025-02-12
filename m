Return-Path: <linux-tip-commits+bounces-3358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31470A3228F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E5A7A145E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D14209684;
	Wed, 12 Feb 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WvUfhgYz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969C209669;
	Wed, 12 Feb 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353056; cv=none; b=uE6Q0uq4yp2xYW89Gn1SFEL0N+4Xl0cusWpRGfGjhdj4hGNkPSmgMcZXnYUCRBCfOFPkAB0WNbbPRW4fAFFybY3bNMPi4vzyjxn/ww18hU+qF3spLc07il3EhMLftb+P/f61S61OESUeNVVAHjOkw34pEXIeWSb5SiD0WuALNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353056; c=relaxed/simple;
	bh=g/jxvtEieoR9thBQ1v/PKEAtaAP8MyOBWUQMZHkH7cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmk/DLlBrFwbm2YjLNDdY1c/XuHwdtilXTfbFjr609qN4olGTbs3Dcqamvvtb6fYJ+1VAzM7yTabTw9snvkNdLJbfR5cgEPVgZHHV1BsSz2To3alKHRrtgCbjvInXi4FuYYoJfD76/tPDSKJgmiI5tzJ/5tsdvIzjQXR5Xuku7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WvUfhgYz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HEALg1IGx6/LckpOQHDyFWyXlK0VFMy3UaS9Vl8dN20=; b=WvUfhgYz5XWHXsspF+k3YI8aZ3
	Ex1OmuY1woiRJBeky/G9aVU6xWErS6aj+eDCxkrGzdLnr7WP2AikaGyY9ZdqKHKt98eolDfwI+ZJn
	e1UVj+K3kYJqRHTWWjTDZou/zlw5NpYotKiFCVgCVSIl8KvVdKjysmc+pCfit/jln3RSRvLiOuGjY
	45i8k4eJHxYTY+bYQVU882JiQ6bDm1w/29XxLY0tokFHs9dR8s7QtyCpLE5G1usTCLm7nQMxduXAX
	g32qE61Zjx0/xVSjOcoyVad7nWD9LXMcK5/6ay5invyY/zSSP0Hn515KxVwoKyhcWjJR4jRdMoKzg
	61t7SDlg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ti9BL-00000004AIA-0oYB;
	Wed, 12 Feb 2025 09:37:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F84E300318; Wed, 12 Feb 2025 10:37:21 +0100 (CET)
Date: Wed, 12 Feb 2025 10:37:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Cristian Prundeanu <cpru@amazon.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geoff Blake <blakgeof@amazon.com>, Csaba Csoma <csabac@amazon.com>,
	Bjoern Doebel <doebel@amazon.com>,
	Gautham Shenoy <gautham.shenoy@amd.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] [tip: sched/core] sched: Move PLACE_LAG and
 RUN_TO_PARITY to sysctl
Message-ID: <20250212093721.GA24784@noisy.programming.kicks-ass.net>
References: <20250119110410.GAZ4zcKkx5sCjD5XvH@fat_crate.local>
 <20250212053644.14787-1-cpru@amazon.com>
 <20250212091711.GA19118@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212091711.GA19118@noisy.programming.kicks-ass.net>

On Wed, Feb 12, 2025 at 10:17:11AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2025 at 11:36:44PM -0600, Cristian Prundeanu wrote:
> > Replacing CFS with the EEVDF scheduler in kernel 6.6 introduced
> > significant performance degradation in multiple database-oriented
> > workloads. This degradation manifests in all kernel versions using EEVDF,
> > across multiple Linux distributions, hardware architectures (x86_64,
> > aarm64, amd64), and CPU generations.
> > 
> > Testing combinations of available scheduler features showed that the
> > largest improvement (short of disabling all EEVDF features) came from
> > disabling both PLACE_LAG and RUN_TO_PARITY.
> > 
> > Moving PLACE_LAG and RUN_TO_PARITY to sysctl will allow users to override
> > their default values and persist them with established mechanisms.
> 
> Nope -- you have knobs in debugfs, and that's where they'll stay. Esp.
> PLACE_LAG is super dodgy and should not get elevated to anything
> remotely official.

Just to clarify, the problem with NO_PLACE_LAG is that by discarding
lag, a task can game the system to 'gain' time. It fundamentally breaks
fairness, and the only reason I implemented it at all was because it is
one of the 'official' placement strategies in the original paper.

But ideally, it should just go, it is not a sound strategy and relies on
tasks behaving themselves.

That is, assuming your tasks behave like the traditional periodic or
sporadic tasks, then it works, but only because the tasks are limited by
the constraints of the task model.

If the tasks are unconstrained / aperiodic, this goes out the window and
the placement strategy becomes unsound. And given we must assume
userspace to be malicious / hostile / unbehaved, the whole thing is just
not good.

It is for this same reason that SCHED_DEADLINE has a constant bandwidth
server on top of the earliest deadline first policy. Pure EDF is only
sound for periodic / sporadic tasks, but we cannot assume userspace will
behave themselves, so we have to put in guard-rails, CBS in this case.


