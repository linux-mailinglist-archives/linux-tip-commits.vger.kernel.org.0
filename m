Return-Path: <linux-tip-commits+bounces-7780-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E936FCEFA90
	for <lists+linux-tip-commits@lfdr.de>; Sat, 03 Jan 2026 05:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0337B3001189
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Jan 2026 04:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A122940D;
	Sat,  3 Jan 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="Bd+UUGQr"
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EB4A3E
	for <linux-tip-commits@vger.kernel.org>; Sat,  3 Jan 2026 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767413356; cv=pass; b=gpmu9dYm5wkCXQu+KbN7V15TAEWXSF0LNO1OAXQqDNTsCTGoTn0j0QVOf/5o1fbSgd5v9d//vqfNqyJIi7GAsbl04kxR2UIsXIIFGKoDGX9T44yJlbo/ka9LNcFKoRe3zdTlATeaTpOEQEAXgSSiEPSeCuzM3qE8XgTHbEnZXcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767413356; c=relaxed/simple;
	bh=bPuEfX0yyxelc1Sv8G312XMxRBrR4zzrR9+lO6vSmrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSOfDrMdJiylp8jF6UrZeO6i0UrqICh1KdvBsmiH1WCrM+er7Oxm3nKT30ISV8u5Od8LMjr6GBGfWVBBYXczjCHEjaMVJhf7f+bytBAcD/ee7NF6w9btP31H0hLRvXFUe1/VULYse4odFAgaC+Baj9SpSmPYHZCNkcgaEw1tq4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=Bd+UUGQr; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7BB98582828
	for <linux-tip-commits@vger.kernel.org>; Sat, 03 Jan 2026 01:47:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.106.233.210])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0DA1E582832
	for <linux-tip-commits@vger.kernel.org>; Sat, 03 Jan 2026 01:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1767404824;
	b=58xi/i1UfpTPOkIaeVCkGx/pBm9/nDTye8ocRGf9VOldM9zurV39gdCCvFl+Pwl1zKILaG
	XTUzzHby6+ucUhWMJXO7WpO9Irheah7gXyx9uMAWZHFxEbSqLJczlCdF0okpxp+3P7/VdP
	S+lhR4LOYHgk0u7TfUSqJd1S3KU5uxSCslfHbaOJPG59YMOoSxEeHMAnZxEkc3EDdVke9m
	S4p3/9sskO8FpkYd1t1l4UPe5HG7k2GsSo7K0HXgSnnXBoLKmobbFs8Ea/dxFZLHGwn5rJ
	UYYepgvj4o5aizkz0E8c85DIVW+4vvKxzEQIsiSV127TuQq9/+OlcD5emL4fzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1767404824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f9YFi8lLVjnAU8ooH57/ylvUgZtmXHB+FkrW4QEucOg=;
	b=Pv65KHeuAMT86gD3HzcslpMX+gK32p3EZSyoQ6yBBx1GAktyqr8slX1Mi5DI6Ln7d71YrY
	PYPyH5pWD98iWOZjwkNkPXodQq5/ZVPnBAKrYNuDTu8ggh8zD2tjiiXC7RqXHRzGg0CZ1s
	2UFjJPt3pHHqkjyxeNEtFeaS8RYd3BtJ6JKNjt3i5uLWDN5mW9+qya0CgQraD38xFItANp
	RKSpEsfCGNfCkak4naGQt7SRklcrie793Z6Iddvm/CisMupGTTPFI1PwSMq9xtOyR7wMct
	zxAKhVrKhb9sT9oVo4vDUzvIKssCe48qmkfGP3RKalMsmR6d+Trl8ZFurykZVg==
ARC-Authentication-Results: i=1;
	rspamd-69599c6f48-ggnnh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Absorbed: 2a0273e75f6eaf93_1767404824244_2459701428
X-MC-Loop-Signature: 1767404824244:109577145
X-MC-Ingress-Time: 1767404824244
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.233.210 (trex/7.1.3);
	Sat, 03 Jan 2026 01:47:04 +0000
Received: from kmjvbox.templeofstupid.com (c-73-241-240-52.hsd1.ca.comcast.net [73.241.240.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4djk2H5tYzzyrC
	for <linux-tip-commits@vger.kernel.org>; Fri,  2 Jan 2026 17:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1767404823;
	bh=f9YFi8lLVjnAU8ooH57/ylvUgZtmXHB+FkrW4QEucOg=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=Bd+UUGQrnAxktgXc2etpXnqMmCoIlPY7FaluTy0eV8f3bbUZNq48ELOPl24AC5tGM
	 TUVfo/19axLvEoAUBu3GzYeyPQAQBfb31wxwsqt8d5lWF5UeutwKdWmUZBxi3SP+VA
	 5ZL4pXsfHvgWIs/UjEu+gT+UUsDPFZq96CvUcpivStwyHnEKsckc83Pp91wfydAyM1
	 ctkLV13Um57MWZluLI57FUT8hGPDtq2Knob1Ebz3vKyOCh0ceLkNBSAmUcx/JNBPZh
	 Hz0UMK0j6TK18yUrajdPLlQmhLTlHPkZJDOO0hII+CbehNaMvL9VbQclgsoMaRoiMK
	 ScU3QOAyd+oaw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0179
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.13);
	Fri, 02 Jan 2026 17:47:02 -0800
Date: Fri, 2 Jan 2026 17:47:02 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Cruz Zhao <CruzZhao@linux.alibaba.com>, tip-bot2@linutronix.de,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	mingo@kernel.org, x86@kernel.org,
	Peng Wang <peng_wang@linux.alibaba.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:sched/urgent] sched/fair: Clear ->h_load_next when
 unregistering a cgroup
Message-ID: <aVh1Fiar6aC4W_1D@templeofstupid.com>
References: <176478073513.498.15089394378873483436.tip-bot2@tip-bot2>
 <20251229125109.1995077-1-CruzZhao@linux.alibaba.com>
 <CAKfTPtCQW_Oj+P6nGx0nVO01CahSEqxuToO8kg=oe3yfuViOwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCQW_Oj+P6nGx0nVO01CahSEqxuToO8kg=oe3yfuViOwg@mail.gmail.com>

Hi Vincent,

On Mon, Dec 29, 2025 at 02:58:16PM +0100, Vincent Guittot wrote:
> On Mon, 29 Dec 2025 at 13:51, Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
> > I noticed that the following patch has been queued in the
> > tip:sched/urgent branch for some time but hasn't yet made
> > it into mainline:
> > https://lore.kernel.org/all/176478073513.498.15089394378873483436.tip-bot2@tip-bot2/
> >
> > Could you please check if there's anything blocking its
> > merge? I wanted to ensure it doesn’t get overlooked.
> 
> From an off list discussion w/ Peter, we need to check that this patch
> is not hiding the root cause that task_h_load is not called in the
> right context i.e. with rcu_read_lock(). Peter pointed out one place
> in numa [1]
> 
> [1] https://lore.kernel.org/all/20251015124422.GD3419281@noisy.programming.kicks-ass.net/

If it helps, I've double-checked this code a few times.  When I looked,
there were 7 different callers of task_h_load(), and they decompose into
3 cases.

1. rcu_read_lock is held as we expect
2. the numa balancing cases Peter already identified
3. tick related invocations, where the caller is in interrupt context

For 3, there's an edge case where deferred work is scheduled if the
target cpu is in full nohz mode and has stopped.

In the cases where I'm hitting this bug, the systems aren't using numa
balancing and aren't using nohz. 90% of ones I've analyzed are in a
futex wakeup and are holding the rcu_read_lock.

This seems like just a case of the pointer continuing to reference
memory that was already free'd.  If the task group's sched entity is
freed, but the parent cfs_rq still has a pointer to that sched_entity in
h_load_next, then it may end up accessing that memory accidentally if we
do not clear it.

Put another way, even if all of these callers used rcu_read_lock, there
would still be a need to ensure that the parent's h_load_next doesn't
point to a sched entity that is free'd once the RCU read-side critical
section is exited, because the child is getting free'd and not the
parent.  The (freed) child is still discoverable from the parent's
h_load_next after the critical section because the delete code does not
clear h_load_next and order that write before the free.

-K

