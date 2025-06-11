Return-Path: <linux-tip-commits+bounces-5774-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA087AD5A41
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 17:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70013A38BA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986971A83E8;
	Wed, 11 Jun 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PV4/tJLC"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2D19CCFA;
	Wed, 11 Jun 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655223; cv=none; b=QcJ7jx570MPs2i/xfRR3gzsh6s3hzf7rOmiFGrZm5e9x02KNpPswr8M+KqSTf2O5ZR6Re9R68NPjAIgC3zreHOKFyku6eRvk/bvD7Y4776/H/4EdPg9JdTj3NZTN7yBlzB8WmtxDTe5Wj1PgyUhx9UNz2OPkDawoALav/WvR/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655223; c=relaxed/simple;
	bh=NohXNpmsdTjOJpAWWdAFFnAbb0o5/myN9L3C50WQkeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrurJJdwUCf6Uc87a4VvSROuVg9EOSUIJmITaC4fChecRZl18/CPCnbMU81KSY8EVnwybq6WjJ2jj1E4xPnBG7rBcDWxSMKwSa6kXqO6KWcsNG0wS3R9JH0Ir0IAcM0cvHjTMMb52LD95aQQLGIBU2NLLWMip+PpitEAvNDD8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PV4/tJLC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JYIgJLsPyubkJQeP0A1dgUwfI4AQsC5JiM6ZqiStDvE=; b=PV4/tJLCp5T6zxcvYQ2bOoCPkN
	g5yxBt6UYoOAFQ81ehxAPZojUHPyx/5BZNLwMmH54B5qfbR1NiRq+6ZfYMoaLV6Jq2+beAcB9Xp8l
	zP5MEpl2RSHl8zre6T/Fd5NBy5FrY0qHWQu35LfsgdrpJ48ha5nN28ocz7mob5ke+RCtyjpMx8Rkq
	GGRtR+osHqU3ZiN+4xAxmLXddHFz+bZ1FskohZjsyIP+JK/Ex51U2h0wNuhU4diLTwmh6ULlVU1s3
	F/zfcCZ6Nh6nsB1quLP503sq0koZhWjeZkMMpoyV629SvxeaGPbZw68YGX+mrmd2XhPt9MlVoSuae
	Ww2syyQg==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPNFU-00000002QKN-1V0J;
	Wed, 11 Jun 2025 15:20:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D12F308722; Wed, 11 Jun 2025 17:20:19 +0200 (CEST)
Date: Wed, 11 Jun 2025 17:20:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250611152019.GA2273450@noisy.programming.kicks-ass.net>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <20250611144302.1MtYItK6@linutronix.de>
 <20250611151113.GE2273038@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611151113.GE2273038@noisy.programming.kicks-ass.net>

On Wed, Jun 11, 2025 at 05:11:13PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 11, 2025 at 04:43:02PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-06-11 14:39:16 [-0000], tip-bot2 for Sebastian Andrzej Siewior wrote:
> > > The following commit has been merged into the locking/urgent branch of tip:
> > > 
> > > Commit-ID:     703b5f31aee5bda47868c09a3522a78823c1bb77
> > > Gitweb:        https://git.kernel.org/tip/703b5f31aee5bda47868c09a3522a78823c1bb77
> > > Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > AuthorDate:    Mon, 02 Jun 2025 13:00:27 +02:00
> > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > CommitterDate: Wed, 11 Jun 2025 16:26:44 +02:00
> > > 
> > > futex: Allow to resize the private local hash
> > > 
> > > Once the global hash is requested there is no way back to switch back to
> > > the per-task private hash. This is checked at the begin of the function.
> > > 
> > > It is possible that two threads simultaneously request the global hash
> > > and both pass the initial check and block later on the
> > > mm::futex_hash_lock. In this case the first thread performs the switch
> > > to the global hash. The second thread will also attempt to switch to the
> > > global hash and while doing so, accessing the nonexisting slot 1 of the
> > > struct futex_private_hash.
> > > This has been reported by Yi Lai.
> > > 
> > > Verify under mm_struct::futex_phash that the global hash is not in use.
> > 
> > Could you please replace it with
> > 	https://lore.kernel.org/all/20250610104400.1077266-5-bigeasy@linutronix.de/
> > 
> > It also looks like the subject from commit bd54df5ea7cad ("futex: Allow
> > to resize the private local hash")
> 
> Now done so, unless I messed up again :/

ARGH, let me try that again :-(

