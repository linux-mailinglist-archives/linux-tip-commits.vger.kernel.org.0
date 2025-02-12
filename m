Return-Path: <linux-tip-commits+bounces-3356-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD696A31E11
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 06:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F346188AF3E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 05:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B81F5428;
	Wed, 12 Feb 2025 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nRMcv++z"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF8271837;
	Wed, 12 Feb 2025 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338888; cv=none; b=HORa0KjBr5UrC52Ln22hcIkG2Ii6eQGVfnfGhakpifzWO/XGTkEpCQsird5lCVyr2tw6Jx1ffh7bSsQQ04oaCw/9XOMFoSdRE3zs119Ol8fx4P2YxwL5nv4z1GkrjqUMLLOiUcANsdVVHxhSJj/ot9/titLd5IUc/+hpN+9jjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338888; c=relaxed/simple;
	bh=BY6O1lds2KXPM53lXWsGjPx720G7GVvSCm3lm6ZoEbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7IWb870Ot0kJMDOHgD+TB8OVxEhxEC3p3bon0w7bBO0unw2x3RD+0KcKjUB3xvGmmMt6IC5t6TcbUrQmMy1vFx9r0sX9viTXy4G3DnaOKF1nkbzudycfuj5je1vlM7WWzXlgng/L2HBsky6nhhLuXHhuFFLzz9zVrBLoFXWiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nRMcv++z; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739338887; x=1770874887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gfE2X9xP7erlqI3KPIjHQxBkm4SGTEH7VMOREGQ43I=;
  b=nRMcv++zPruedIS4oAEeORY9b+d7hC0G4+/wZmgGGMklBgJ8z4ucpxRA
   KyNdskKKF7RqPAGQh5B8UaS5TD1cNhuNDUDJwu4hJWAN7zAPvGLvb/ijr
   UnrsN0Kfn9hmBotoqOU9iRxEUOBAgI5Ig1boSM6A8Onaz3rJ6g90ZOJ/R
   U=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="798097614"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:41:26 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:25574]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.246:2525] with esmtp (Farcaster)
 id b73d078c-8489-43c2-8a48-97d423604b5d; Wed, 12 Feb 2025 05:41:25 +0000 (UTC)
X-Farcaster-Flow-ID: b73d078c-8489-43c2-8a48-97d423604b5d
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 05:41:25 +0000
Received: from 88665a51a6b2.amazon.com (10.106.179.55) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 05:41:23 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Cristian Prundeanu <cpru@amazon.com>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Ali Saidi <alisaidi@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Geoff Blake <blakgeof@amazon.com>,
	Csaba Csoma <csabac@amazon.com>, Bjoern Doebel <doebel@amazon.com>, "Gautham
 Shenoy" <gautham.shenoy@amd.com>, Joseph Salisbury
	<joseph.salisbury@oracle.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tip-commits@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY and move them to sysctl
Date: Tue, 11 Feb 2025 23:41:13 -0600
Message-ID: <20250212054113.19938-1-cpru@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <feb31b6e-6457-454c-a4f3-ce8ad96bf8de@amd.com>
References: <20250119110410.GAZ4zcKkx5sCjD5XvH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

Hi Prateek,

Thank you for the analysis details!

> Thank you for the reproducer. I haven't tried it yet (in part due
> to the slightly scary "Assumptions" section)

It wasn't meant to be scary, my apologies. It is meant to say that the 
reproducer will only perform testing-related tasks (which you'd normally 
do manually), without touching the infrastructure (firewall, networking, 
instance mangement, etc). As long as you set all that up the same way you 
do when you test manually, you will be fine. I'll clarify the README.

Should you run into any questions, please do not hesitate to contact me 
directly, and I'll help clear the path.

> v6.14-rc1                   baseline
> v6.5.0 (pre-EEVDF)          -0.95%
> v6.14-rc1 + NO_PL + NO_RTP  +6.06%

This is interesting. While you do reproduce the benefits of NO_PL+NO_RTP, 
your result shows no regression compared to the baseline CFS. I'm only 
speculating, but running both SUT and loadgen on the same machine is a 
large variation of the test setup, and can lead to result differences like 
this one.

> Digging through the scripts, I found that SCHED_BATCH setting is done
> via systemd in [3] via the "CPUSchedulingPolicy" parameter.
> [3] https://github.com/aws/repro-collection/blob/main/workloads/mysql/files/mysqld.service.tmpl

That is correct, the reproducer uses systemd to set the scheduler policy 
for mysqld.

> interestingly, if I do (version 1): [...]
> I more or less get the same results as baseline v6.14-rc1 (Weird!)
> But then if I do (version 2): [...]
> I see the performance reach to the same level as that with NO_PL +
> NO_RTP.

That's a good find. I will compare on my setup if performance changes when 
manually setting all mysqld tasks to SCHED_BATCH. And I haven't yet run 
perf sched stats on the reproducer, but it may hold useful insight. 
I'll follow up with more details as I gather them.

Your find also helps to point out that even when it works, SCHED_BATCH is 
a more complex and error prone mitigation than just disabling PL and RTP. 
The same reproducer setup that uses systemd to set SCHED_BATCH does show 
improvement in 6.12, but not in 6.13+. There may not even be a single 
approach that works well on both.

Conversely, setting NO_PLACE_LAG + NO_RUN_TO_PARITY is simply done at boot 
time, and does not require further user effort. It's even simpler if those 
two features are exposed via sysctl, making it trivial to pesist and query 
with standard Linux commands as needed. 

Peter, I've renewed my initial patch so it applies to the current 
sched/core, and removed the dependency on changing the default values 
first. I'd appreciate you considering it for merging [1].

[1] https://lore.kernel.org/20250212053644.14787-1-cpru@amazon.com

-Cristian

