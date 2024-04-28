Return-Path: <linux-tip-commits+bounces-1188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC368B4BF0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 28 Apr 2024 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3471C20E03
	for <lists+linux-tip-commits@lfdr.de>; Sun, 28 Apr 2024 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620016CDBC;
	Sun, 28 Apr 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qh4mhEM3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7D6BB2F
	for <linux-tip-commits@vger.kernel.org>; Sun, 28 Apr 2024 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714310301; cv=none; b=akf8LdSBilyKoirbcn2Bo7xKCVHsVGPql4HYKYkoLtSR1q7EzvI4gOs9zXRn0C605hMJ8QBYBC01FF9wjgLWYQX70IeC6+0NPZ8+CMzokUPlKyIy11HdcUTKsIpH3L/z8zd61i5uDERmTzh49gTl1x0gUtFfi/hbxAm/jYFebbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714310301; c=relaxed/simple;
	bh=CgfUEtVUVqryBOU20Pw4HvjHv8QjwbFcKFGTsksoSUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cof9s5DigPBu1I3haBCxWfchjCk/FMOchgcTXSfr/RQVHfkMcoOG7pdSP5hGt0O2qsxrpAhqBHAFbVD+olmgeE8v/j6FU4aWtkZnjOJK0iLCytxJyTPG1gp9pvjjHcJWQ/tFXMnLOXEGryLriNxijFz/fJxtoSQHCaQmXpRL8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qh4mhEM3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714310298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgfUEtVUVqryBOU20Pw4HvjHv8QjwbFcKFGTsksoSUQ=;
	b=Qh4mhEM3ndISM0Uvx5TXZpKDdIcJyTAl7wqA57HrhkHWBuW6EmK6WY+9/+Yrw+Vd30CVyH
	cWslilGaXCRtn1EKqhI3ql9+1WARZekxssSK7UUOBQ8RkB1kubAR6t19IL6kIRm+zwcRXg
	KLEw81hX2tDU8uLdRXmXo8MSEjk+mns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ZC-jobWDMySgLHBythwwfg-1; Sun, 28 Apr 2024 09:18:14 -0400
X-MC-Unique: ZC-jobWDMySgLHBythwwfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E55E98059E0;
	Sun, 28 Apr 2024 13:18:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.143])
	by smtp.corp.redhat.com (Postfix) with SMTP id 37A2040C6CB1;
	Sun, 28 Apr 2024 13:18:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 28 Apr 2024 15:16:48 +0200 (CEST)
Date: Sun, 28 Apr 2024 15:16:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/isolation: Fix boot crash when maxcpus
 < first housekeeping CPU
Message-ID: <20240428131645.GA20436@redhat.com>
References: <20240413141746.GA10008@redhat.com>
 <171398910207.10875.4426725644764756607.tip-bot2@tip-bot2>
 <Zi4FHsc51wNhdSW4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi4FHsc51wNhdSW4@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 04/28, Ingo Molnar wrote:
>
> * tip-bot2 for Oleg Nesterov <tip-bot2@linutronix.de> wrote:
>
> > Another corner case is "nohz_full=0" on a machine with a single CPU or with
> > the maxcpus=1 kernel argument. In this case non_housekeeping_mask is empty
> > and tick_nohz_full_setup() makes no sense. And indeed, the kernel hits the
> > WARN_ON(tick_nohz_full_running) in tick_sched_do_timer().
> >
> > And how should the kernel interpret the "nohz_full=" parameter? It should
> > be silently ignored, but currently cpulist_parse() happily returns the
> > empty cpumask and this leads to the same problem.
> >
> > Change housekeeping_setup() to check cpumask_empty(non_housekeeping_mask)
> > and do nothing in this case.
>
> So arguably the user meant NOHZ_FULL to be turned off - but it is de-facto
> already turned off by the fact that there's only a single CPU available,
> right?

Or the user passes the empty "nohz_full=" mask on a multi-CPU machine.

In both cases (before this patch) housekeeping_setup() calls
tick_nohz_full_setup(non_housekeeping_mask) which sets
tick_nohz_full_running = true even if tick_nohz_full_mask is empty.

This doesn't look right to me and triggers the "this should not happen"
warning in tick_sched_do_timer().

But let me repeat, I know nothing about nohz/etc.

Oleg.


