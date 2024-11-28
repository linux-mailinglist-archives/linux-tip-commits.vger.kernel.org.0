Return-Path: <linux-tip-commits+bounces-2892-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410709DB5C5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Nov 2024 11:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA32516211B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Nov 2024 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF1155A25;
	Thu, 28 Nov 2024 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jyOkTTNj"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DA15383C;
	Thu, 28 Nov 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790027; cv=none; b=kA/AfNGzr7LE0uDFl2rhEp3uyKwtNnXvXCMw1n0wUsOaMsC2mI9FYrkVZKuilEzT3itri2qq/WogV91D/C7+vcsXL95012Z1NI7dZTCjQsvI2LUGvxNP7Xj5mPWjpSoW4arYBFanX0BfJg8GplQF/hLVcOSEpD/jKLqo8QWkumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790027; c=relaxed/simple;
	bh=zgdyVn/+nOYYJ+Vdw99bJ+5oJo7PPJaiH2UCJzw970g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QympH1fCVhG71iXjDM89yvF1f+ssG9fF3Giha747vB9A/WzUK4nloiXcljAoCBxOI38d0oxsfaOgp5R1VJFQul+ViEZUVyVykXwnfAoo9hMwYxW3VXz+2F8ihHDB31449RB0agg0I8OVPdm172dRtzS8hB58TrffaYbGTGj9a+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jyOkTTNj; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732790026; x=1764326026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3cjb0+0e787fmSia9xKiS5vCKypEydvQhshZnRtBb4s=;
  b=jyOkTTNj3GfsTpTM/RQYPXNJqKzydkmLFuiuTKiVLjs9O4qZbWL+pxzC
   TZoV+ARMYTaqboURwzfyGb+8gNBhVtMho4J1aGPBz6tv15xMnBPvr5UHq
   RFCs8W3djEvvAVCc358h9g20DTcm+zai7Pg2l9MuZmLMh4pq3tSmdCQKX
   k=;
X-IronPort-AV: E=Sophos;i="6.12,192,1728950400"; 
   d="scan'208";a="473917503"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 10:33:45 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:49797]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.41:2525] with esmtp (Farcaster)
 id 252a3a4d-81ab-4111-b181-493c14bd6249; Thu, 28 Nov 2024 10:33:44 +0000 (UTC)
X-Farcaster-Flow-ID: 252a3a4d-81ab-4111-b181-493c14bd6249
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 10:33:44 +0000
Received: from 88665a51a6b2.amazon.com (10.106.178.48) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 10:33:41 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: <cpru@amazon.com>
CC: <abuehaze@amazon.com>, <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
	<blakgeof@amazon.com>, <csabac@amazon.com>, <dietmar.eggemann@arm.com>,
	<doebel@amazon.com>, <gautham.shenoy@amd.com>, <joseph.salisbury@oracle.com>,
	<kprateek.nayak@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY and move them to sysctl
Date: Thu, 28 Nov 2024 04:32:36 -0600
Message-ID: <20241128103236.22777-1-cpru@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125113535.88583-1-cpru@amazon.com>
References: <20241125113535.88583-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

On 2024-11-26, K Prateek Nayak wrote:

> Would it be possible to use the perf-tool built there to collect
> the scheduling stats for MySQL benchmark runs on both v6.5 and v6.8 and
> share the output of "perf sched stats diff" and the two perf.data files
> recorded?

I'll add this to the list of my next tests. Thank you for mentioning it!


On 2024-11-26, Dietmar Eggemann wrote:

> SUT kernel arm64 (mysql-8.4.0)
> (2) 6.12.0-rc4                -12.9%
> (3) 6.12.0-rc4 NO_PLACE_LAG   +6.4%		
> (4) v6.12-rc4  SCHED_BATCH    +10.8%

This is very interesting; our setups are close, yet I have not seen any 
feature or policy combination that performs above the 6.5 CFS baseline.
I look forward to seeing your results with the repro when it's ready.

Did you only use NO_PLACE_LAG or was it together with NO_RUN_TO_PARITY?

Was SCHED_BATCH used with the default feature set (all enabled)?

Which distro/version did you use for the SUT?

> Maybe a difference in our test setup can explain the different test results:
>
> I use:
>
> HammerDB Load Generator <-> MySQL SUT
> 192 VCPUs               <-> 16 VCPUs
> 
> Virtual users: 256
> Warehouse count: 64
> 3 min rampup
> 10 min test run time
> performance data: NOPM (New Operations Per Minute)
>
> So I have 256 'connection' tasks running on the 16 SUT VCPUS.

My setup:

SUT     - 16 vCPUs, 32 GB RAM
Loadgen - 64 vCPU, 128 GB RAM (anything large enough to not be a 
 bottleneck should work)

Virtual users:  4 x vCPUs = 64
Warehouses:     24
Rampup:         5 min
Test runtime:   20 min x 10 times, each on 4 different SUT/Loadgen pairs
Value recorded: geometric_mean(NOPM)

