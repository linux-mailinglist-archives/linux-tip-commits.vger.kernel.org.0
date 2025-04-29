Return-Path: <linux-tip-commits+bounces-5136-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B470EAA3A3E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 23:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C483B0479
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852822A7ED;
	Tue, 29 Apr 2025 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KmSJYFvs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92651E282D;
	Tue, 29 Apr 2025 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963778; cv=none; b=kCQbqiyYmG3QZ9bZFg0BeVh/rfkpUwxEAgfYElyKqUmwXdvYzlJYQwDMT612PeR4ZzWYK49LK9gI6QEB2rnVSAVX2E0BrzymIJhAaOSqRaWPDOwGOV4lN8Nujw79OUj9dj0UO4DP1z4z/ownVqe1RlFHuAJZ4ss1yPRc8ZH1Ud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963778; c=relaxed/simple;
	bh=3S7n0Y8vfnS9V8Uy6Sw3Ev9mKH+II66wb2WDjsCsHNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcd6FCSIQf6tYzZjYhlDl6honiJWwieAAimc0zgH71BPZSU2CLF6FNgYlLLIKmKwLnaUuDpnt0QUsbfuVPJzK0JIzjurVuboH+Hl3frb5HHr5NSyyMOrS01YXTrGHv48L985X6GPulFm24nBNssowS5OB0F2+lnia+1dsdGrRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KmSJYFvs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZgKR/aK6M3ZJDk7DeAJjGJw01SYV+7z18ycrliw9Mj0=; b=KmSJYFvs5c2pEmZpIertWrJMEP
	bZOCZQb9dESY2bWXR24y5clY35dUYN7zEdj97CB4ROV6KGStYUpI3n/4pUXobQmOqazCMyR0VQC24
	mzZk4l4SLQFOwMPSd8a8d/h94ktT3JYC6afRP+HDQh+knharCd2goPbdTBFNNNKp3a2yPSwk4fPAN
	FAeU6v1E8qWCtFOkAesk3V9R5mPLyPHLvLzKM5QHlMydNcVWZSFFBX4z5RwnD8OBrWO02qUXtMKYf
	tW76vJHP+RYg6FEiuj4rzABtUZylm+rf7Kz8gmnxp7dDfOTPpr6oVJ+i1lpnzrl+DLBScUqgdk2SO
	HpB92TvA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9svt-0000000DXCy-13qA;
	Tue, 29 Apr 2025 21:56:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B06C630057C; Tue, 29 Apr 2025 23:56:04 +0200 (CEST)
Date: Tue, 29 Apr 2025 23:56:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Cristian Prundeanu <cpru@amazon.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geoff Blake <blakgeof@amazon.com>, Csaba Csoma <csabac@amazon.com>,
	Bjoern Doebel <doebel@amazon.com>,
	Gautham Shenoy <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: EEVDF regression still exists
Message-ID: <20250429215604.GE4439@noisy.programming.kicks-ass.net>
References: <20250429213817.65651-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429213817.65651-1-cpru@amazon.com>

On Tue, Apr 29, 2025 at 04:38:17PM -0500, Cristian Prundeanu wrote:
> Peter,
> 
> Here are the latest results for the EEVDF impact on database workloads. 
> The regression introduced in kernel 6.6 still persists and doesn't look 
> like it is improving.

Well, I was under the impression it had actually been solved :-(

My understanding from the last round was that Prateek and co had it
sorted -- with the caveat being that you had to stick SCHED_BATCH in at
the right place in MySQL start scripts or somesuch.

Prateek, Gautham?


