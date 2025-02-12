Return-Path: <linux-tip-commits+bounces-3360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB721A33308
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Feb 2025 00:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399623A373D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF6205AD1;
	Wed, 12 Feb 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vv51547q"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30520459F;
	Wed, 12 Feb 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401217; cv=none; b=KM1Qck1QZXVcaTABSnP88ixhGDzGLQTCHHbMb6XGFSeZPTD2qJLinv2/ZkJK217W500kKW6XF7gj5paDxAqbRzUIB4VIRKY0OpNDZOpbdRZxgXItj7HIAccnOaEo4cohBrE9jvvvjzqtDg09MoTRtFPR0WtfbHAR6Bc1y2XqZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401217; c=relaxed/simple;
	bh=F06D85fC7sZsGUybTqzR1LHr5Ksh6SGgS7n+vqCsfgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd5U7Ga0twpOtHo2TuUf9jjb56nl6cnqYoPkk1+p/uYTwpdNgRbDSs//bNgZr4mlQVo8KZBOY8VIamqUkfCrdARxwCoSYCEFbgQ8bvaZJct0/SmRcxxRdpcQNvwmFP1s6CyvQb/oUWzAO9tZlUQLRy7WRiUe6RdWA1KDEUZhQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vv51547q; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739401215; x=1770937215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7clgdrBcayHFAivKWtedT4B5oeFGJNEZp+u1MEeMxvU=;
  b=Vv51547qJdAgXCgoIkeELo4nTM+o2BDtqLUSCXZKNyvcCq6rQvWpk5rz
   W5MP9AmJVrRfrTImXOfJvwDEhtTnbSPsnDr3BlBuWZAGkCzJCD6Ydt+Jg
   sP7MSpNxyglt//2Kkq6mhF6TQhIRRnGMlpOG2ySDepXO0Iak5/NHbHGQZ
   E=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="171993392"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:00:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:20924]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.187:2525] with esmtp (Farcaster)
 id 46ec316a-84fc-48d3-81a3-a13e85f75502; Wed, 12 Feb 2025 23:00:15 +0000 (UTC)
X-Farcaster-Flow-ID: 46ec316a-84fc-48d3-81a3-a13e85f75502
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 23:00:15 +0000
Received: from 88665a51a6b2.amazon.com (10.106.179.55) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 23:00:12 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Cristian Prundeanu <cpru@amazon.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	"Ali Saidi" <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Geoff Blake <blakgeof@amazon.com>, Csaba Csoma
	<csabac@amazon.com>, Bjoern Doebel <doebel@amazon.com>, Gautham Shenoy
	<gautham.shenoy@amd.com>, Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov
	<bp@alien8.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>,
	<x86@kernel.org>
Subject: Re: [PATCH v2] [tip: sched/core] sched: Move PLACE_LAG and RUN_TO_PARITY to sysctl
Date: Wed, 12 Feb 2025 17:00:02 -0600
Message-ID: <20250212230002.95945-1-cpru@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212093721.GA24784@noisy.programming.kicks-ass.net>
References: <20250212094307.GB19118@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

>>> Moving PLACE_LAG and RUN_TO_PARITY to sysctl will allow users to override
>>> their default values and persist them with established mechanisms.
>>
>> Nope -- you have knobs in debugfs, and that's where they'll stay. Esp.
>> PLACE_LAG is super dodgy and should not get elevated to anything
>> remotely official.
>
> Just to clarify, the problem with NO_PLACE_LAG is that by discarding
> lag, a task can game the system to 'gain' time. It fundamentally breaks
> fairness, and the only reason I implemented it at all was because it is
> one of the 'official' placement strategies in the original paper.

Wouldn't this be an argument in favor of more official positioning of this 
knob? It may be dodgy, but it's currently the best mitigation option, 
until something better comes along.

> If the tasks are unconstrained / aperiodic, this goes out the window and
> the placement strategy becomes unsound. And given we must assume
> userspace to be malicious / hostile / unbehaved, the whole thing is just
> not good.

Userspace in general, absolutely. User intent should be king though, and 
impairing the ability to do precisely what you want with your machine 
feels like it stands against what Linux is best known (and often feared) 
for: configurability. There is _another_ OS which has made a habit of 
dictating how users should want to do something. We're not there of 
course, but it's a strong cautionary tale.

To ask more specifically, isn't a strong point of EEVDF the fact that it 
considers _more_ user needs and use cases than CFS (for instance, task 
lag/latency)?

>> Conversely, setting NO_PLACE_LAG + NO_RUN_TO_PARITY is simply done at boot 
>> time, and does not require further user effort. 
>
> For your workload. It will wreck other workloads.

I'd like to invite you to name one real-life workload that would be 
wrecked by allowing PL and RTP override in sysctl. I can name three that 
are currently impacted (mysql, postgres, and wordpress), with only poor 
means (increased effort, non-standard persistence leading to higher 
maintenance cost, requirement for debugfs) to mitigate the regression.

> Yes, SCHED_BATCH might be more fiddly, but it allows for composition.
> You can run multiple workloads together and they all behave.

Shouldn't we leave that to the user to decide, though? Forcing a new 
default configuration that only works well with multiple workloads can not 
be the right thing for everyone - especially for large scale providers, 
where servers and corresponding images are intended to run one main 
workload. Importantly, things that used to run well and now don't.

> Maybe the right thing here is to get mysql patched; so that it will
> request BATCH itself for the threads that need it.

For mysql in particular, it's a possible avenue (though I still object to 
the idea that individual users and vendors now need to put in additional 
effort to maintain the same performance as before).

But on a larger picture, this reproducer is only meant as a simplified 
illustration of the performance issues. It is not a single occurrence. 
There are far more complex workloads where tuning at thread level is at 
best impractical, or even downright impossible. Think of managed clusters 
where the load distribution and corresponding task density are not user 
controlled, or JVM workloads where individual threads are not even 
designed to be managed externally, or containers built from external 
dependencies where tuning a service is anything but trivial.

Are we really saying that everyone just needs to swallow the cost of this 
change, or put up with the lower performance level? Even if the Linux 
Kernel doesn't concern itself with business cost, surely at least the time 
burned on this by both commercial and non-commercial projects cannot be 
lost on you.

> Also, FYI, by keeping these emails threaded in the old thread I nearly
> missed them again. I'm not sure where this nonsense of keeping
> everything in one thread came from, but it is bloody stupid.

Thank you. This is a great opportunity for both of us to relate to the 
opposing stance on this patch, and I hope you too will see the parallel:

My reason for threading was well intended. I value your time and wanted to 
avoid you wasting it by having to search for the previous patch or older 
threads on the same topic.

However, I ended up inadvertently creating an issue for your use case. 
It, arguably, doesn't have a noticeable impact on my side, and it could be 
avoided by you, the user, by configuring your email client to always 
highlight messages directly addressed to you; assuming that your email 
client supports it, and you are able and willing to invest the effort to 
do it.
Nevertheless, this doesn't make it right.

I do apologize for the annoyance; it was not my intent to put additional 
burden on you, only to have the same experience or efficiency that you are 
used to having. I did consolidate the two recent threads into this one 
though, because I believe that it's easier to follow by everyone else.

It may be a silly parallel, but please consider that similar frustration 
is happening to many users who now are asked to put effort towards 
bringing performance back to previous levels - if at all possible and 
feasible - and at the same time are denied the right tools to do so.
Please consider that it took years for EEVDF commit messages to go from 
"horribly messes up things" to "isn't perfect yet, but much closer", and 
it may take years still until it's as stable, performant and vetted across 
varied scenarios as CFS was in kernel 6.5.
Please consider that along this journey are countless users and groups who 
would rather not wait for perfection, but have easy means to at least get 
the same performance they were getting before.

-Cristian

