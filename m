Return-Path: <linux-tip-commits+bounces-4534-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C42A700AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 14:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42221733E8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598E26AAAD;
	Tue, 25 Mar 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CxqIZihm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7426AA8C;
	Tue, 25 Mar 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906193; cv=none; b=QbTxoXLmf36duWrhblTMlKnOtZYivYq12GSF5XXXRzjmYLklyLwcRjIQ/RXN83Ll9XKRgmlgQ8HDV3g2sW0gGRsAubKCRno3ZXM7G0c1ftOwP4bDJcFjvP/x8Fmv8fm3/ZMLhm5awZWvzGpFVMlxNglRwRzhB8pYz6baXbZKpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906193; c=relaxed/simple;
	bh=mV79vQ0mZIo8AonPHZubPUmxbkRu5MFUaS7ZWLmjYBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKGqBxjgBRoVEZm7bg4WN5lUfDtbe6gushZd4dtYbtdhg1lfUBZxFVD+hpVphITnGqC3LnAe2OG0H0WQgftby3bmAdV+BKocMDepEAcZhlTJmSqo8POOYTwtJUO+4MloWi9A8/ELut3IXY4t9RtIj01mLgwtuQ40cYkEY7gJmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CxqIZihm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mV79vQ0mZIo8AonPHZubPUmxbkRu5MFUaS7ZWLmjYBw=; b=CxqIZihm+kfj36jS4PO0ebDOkw
	WmVQQ3dNYAmRhnbERHConGclw7ykfSudUGJjMyL0sk9Aguoce+oZdufnDEVRLawnIpjgyP5+a7HOe
	IUva1ThrWa/gcnfWrjNlMObQ0S4f6TxbYHi9GfdGohldU62G5GH51+164IHGpwndcwITgILJH/xea
	2C1okqzL6lf8DYnUxdDNZAZCc2v6UmPbrpeeaUPlcZOhc6nW/rGe5rQPkHJyHnJmzmjO/aQJi6FGt
	aG/WC9s9eTSuhTJglbrPv03pZluGEyatnD+DqEf0DXUnxM097ZudM52sPugXt+2KMSX+kSruInLcn
	iPF+Zovw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tx3W5-000000043LN-2Juy;
	Tue, 25 Mar 2025 12:36:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 25A9E3004AF; Tue, 25 Mar 2025 13:36:25 +0100 (CET)
Date: Tue, 25 Mar 2025 13:36:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [PATCH] bug: Introduce CONFIG_DEBUG_BUGVERBOSE_EXTRA=y to also
 log warning conditions
Message-ID: <20250325123625.GM36322@noisy.programming.kicks-ass.net>
References: <20250317104257.3496611-2-mingo@kernel.org>
 <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net>
 <Z-J5UEFwM3gh6VXR@gmail.com>
 <Z-KRD3ODxT9f8Yjw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-KRD3ODxT9f8Yjw@gmail.com>

On Tue, Mar 25, 2025 at 12:18:39PM +0100, Ingo Molnar wrote:

> So, to argue this via code, we'd like to have something like the patch below?

I would do it differently. If we know the thing is a simple string, we
can stick it in bug_entry and print from __report_bug() without causing
horrific shite at the call site.

The problem with WARN() is that it is a format string, which must be
filled out in situ. Resulting in calls to snprintf() and arguments and
whatnot.

