Return-Path: <linux-tip-commits+bounces-5771-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C5AD5925
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 16:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4499F7A316E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552022BDC08;
	Wed, 11 Jun 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0lgk2TGy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n4QBASFC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13642BD5B2;
	Wed, 11 Jun 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652987; cv=none; b=qSaZO8ty8mV7znSC+MYrAYDgkzEJEHoa2uImpHqxg6UG4uK22cvUCqWbcBjhMr2H1ntanAYTodtmdXAaKj15dyTS5HADu1tehY+Mi6kYFGtfLoETnylW7JSW4JecCnRKuIQa3H1PHbWwxGCovWQpR4CvTNhvdXNLvuVQoI83BA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652987; c=relaxed/simple;
	bh=wwGJy0dwoMBFPbLDeocuOjgOt4Oupsy/855zZ6cqsDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jphgTdgvt880gpT2tn686vi+Mtd2O6yI98ntatIP/11s4nuQ304M/CRbyPSjWxQ3KNAAnQjyjCxAK4ldwexQKOEtlk2+fd44YXAKBUSuXnxXe9tPgetixAPBXyuWolx0WghYvWzCMSEuZT4131rchioTImF/4daIZqpCEeAd15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0lgk2TGy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n4QBASFC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 16:43:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749652984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0rEY4sXW+zSxhO51iT2sK1DgoY1N3HJqIWfx4UYk2CU=;
	b=0lgk2TGyODewkaNv/dLHG28Qfo5tMd5T8UYVY/zSgPbmLNSF1ouuF5+TJwFHp6dOgos/Zy
	syM9a/3J8GUOJUGKQ2sYN6VS21eqcdAT7/QBbZLF5Qn4iKkAScqWYBo/S4Co9QzzEHssu8
	XTGRP6WfEzhWmwPb37vkgBFVz//mB/fwWyigY/sccg+WNkFHaE8XReSFMmogtJyEdlTBiS
	tW26n2oddRiKIXA/Ppidb7XmdBbw2yuQIlugpSFxNZHHXi9G1kjP9wewS5QPaCsNdJJSd7
	GW1CxRDTUi7zcPgtBVoThT4y+45WFNEmq11RlYwCmF/3YXa9sBJ8IW2rcrF9gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749652984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0rEY4sXW+zSxhO51iT2sK1DgoY1N3HJqIWfx4UYk2CU=;
	b=n4QBASFCJc1Bc4HmBI5hao4gWBUt/n0qAHWM3HPggri1iNu7zAQoi/bqpVhbNXD8zh0zLG
	1GbEe+/TFSgAY4DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, "Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250611144302.1MtYItK6@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>

On 2025-06-11 14:39:16 [-0000], tip-bot2 for Sebastian Andrzej Siewior wrote:
> The following commit has been merged into the locking/urgent branch of tip:
> 
> Commit-ID:     703b5f31aee5bda47868c09a3522a78823c1bb77
> Gitweb:        https://git.kernel.org/tip/703b5f31aee5bda47868c09a3522a78823c1bb77
> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate:    Mon, 02 Jun 2025 13:00:27 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 11 Jun 2025 16:26:44 +02:00
> 
> futex: Allow to resize the private local hash
> 
> Once the global hash is requested there is no way back to switch back to
> the per-task private hash. This is checked at the begin of the function.
> 
> It is possible that two threads simultaneously request the global hash
> and both pass the initial check and block later on the
> mm::futex_hash_lock. In this case the first thread performs the switch
> to the global hash. The second thread will also attempt to switch to the
> global hash and while doing so, accessing the nonexisting slot 1 of the
> struct futex_private_hash.
> This has been reported by Yi Lai.
> 
> Verify under mm_struct::futex_phash that the global hash is not in use.

Could you please replace it with
	https://lore.kernel.org/all/20250610104400.1077266-5-bigeasy@linutronix.de/

It also looks like the subject from commit bd54df5ea7cad ("futex: Allow
to resize the private local hash")

Sebastian

