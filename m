Return-Path: <linux-tip-commits+bounces-2625-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B99B41AD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 05:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF3B1F23C42
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 04:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFAE1DE3C6;
	Tue, 29 Oct 2024 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ht1Qk10N"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259821DE4D7;
	Tue, 29 Oct 2024 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730177900; cv=none; b=bxk5L3uws1qsUtMN5Xcek2llRRoYhVKT8iaJbaVjnBrF0SRQojqWcE1P/cvqSpjRM7jysVOIp916jtiUl3tnDLzHLkZBG6t9HMaNgKSyGjSti1PN/bOvRximIfIf8O1Xz8FshH7nEW1S3+FYyKLod/k1ZVGgcPxYYzKO83/1xEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730177900; c=relaxed/simple;
	bh=3ndlmzEfEOtEWSxHZifd70dS3uBcGOkYZcPsLDyx+g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljTehC4UYo3ZKlvI8rTl4TYmt3SlvRIk4zOlv1tGEzyn2M+ibcC8386xRG7cXgdHzXZrkJQW4uuumvuayCk1vTOOa8nvyrAI5dDZNPu1is1xUpfFK15W4QXWxtnlYrZaJCigffluuepDbW7f5zi0YK2NW1dQwtWw6p1ttFjZgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ht1Qk10N; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730177899; x=1761713899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3kGxrzEKbAFqR/0z9ua6srjnJwz1K5VrV6j+QKOXBSA=;
  b=ht1Qk10NHLWGqBxvTxY4kanGI7PHUeBD/b3rBgakgpjTjhm9z1gK/3HY
   cv5QsyDvWFqspwHwRdCkM7664bFDzbGI+wZLCrTBVxL6PLQa8YLlgInfU
   dTfvziDrtRJjRgZVTruvu4GPeVBNUxWDg57H9kdjshfczYXey1nO3Dnqw
   U=;
X-IronPort-AV: E=Sophos;i="6.11,241,1725321600"; 
   d="scan'208";a="691275556"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 04:58:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:56547]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.72:2525] with esmtp (Farcaster)
 id 55ba7e0a-c931-44cc-8af9-06a2c5330a90; Tue, 29 Oct 2024 04:58:15 +0000 (UTC)
X-Farcaster-Flow-ID: 55ba7e0a-c931-44cc-8af9-06a2c5330a90
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 29 Oct 2024 04:58:12 +0000
Received: from 88665a51a6b2.amazon.com (10.106.179.51) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 29 Oct 2024 04:58:10 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC: <linux-tip-commits@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>, Bjoern Doebel
	<doebel@amazon.com>, Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, "Geoff
 Blake" <blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Csaba Csoma
	<csabac@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY and move them to sysctl
Date: Mon, 28 Oct 2024 23:57:49 -0500
Message-ID: <20241029045749.37257-1-cpru@amazon.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com>
References: <ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

Hi Gautham,

On 2024-10-25, 09:44, "Gautham R. Shenoy" <gautham.shenoy@amd.com <mailto:gautham.shenoy@amd.com>> wrote:

> On Thu, Oct 24, 2024 at 07:12:49PM +1100, Benjamin Herrenschmidt wrote:
> > On Sat, 2024-10-19 at 02:30 +0000, Prundeanu, Cristian wrote:
> > > 
> > > The hammerdb test is a bit more complex than sysbench. It uses two
> > > independent physical machines to perform a TPC-C derived test [1], aiming
> > > to simulate a real-world database workload. The machines are allocated as
> > > an AWS EC2 instance pair on the same cluster placement group [2], to avoid
> > > measuring network bottlenecks instead of server performance. The SUT
> > > instance runs mysql configured to use 2 worker threads per vCPU (32
> > > total); the load generator instance runs hammerdb configured with 64
> > > virtual users and 24 warehouses [3]. Each test consists of multiple
> > > 20-minute rounds, run consecutively on multiple independent instance
> > > pairs.
> > 
> > Would it be possible to produce something that Prateek and Gautham
> > (Hi Gautham btw !) can easily consume to reproduce ?
> > 
> > Maybe a container image or a pair of container images hammering each
> > other ? (the simpler the better).
> 
> Yes, that would be useful. Please share your recipe. We will try and
> reproduce it at our end. In our testing from a few months ago (some of
> which was presented at OSPM 2024), most of the database related
> regressions that we observed with EEVDF went away after running these
> the server threads under SCHED_BATCH.

I am working on a repro package that is self contained and as simple to 
share as possible.

My testing with SCHED_BATCH is meanwhile concluded. It did reduce the 
regression to less than half - but only with WAKEUP_PREEMPTION enabled. 
When using NO_WAKEUP_PREEMPTION, there was no performance change compared 
to SCHED_OTHER.

(At the risk of stating the obvious, using SCHED_BATCH only to get back to 
the default CFS performance is still only a workaround, just as disabling 
PLACE_LAG+RUN_TO_PARITY is; these give us more room to investigate the 
root cause in EEVDF, but shouldn't be seen as viable alternate solutions.)

Do you have more detail on the database regressions you saw a few months 
ago? What was the magnitude, and which workloads did it manifest on?

-Cristian

