Return-Path: <linux-tip-commits+bounces-8017-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423AAD28CE0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB69B3017E53
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B532B98E;
	Thu, 15 Jan 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p1jNcbiO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3yCDbnGd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE57329361;
	Thu, 15 Jan 2026 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513446; cv=none; b=oeoxGeo46xq6tFCroE7tzbmAqnrchwOw2q4+avrJJ5dVoK2BncQiV0KULoc0N4iOOgiPMTNkZeAoFZS+x5B0t+cvyVMlb4CPWNxvkFqPBDm32C/GpWFN6ITf5m7fBxUCqKiYKlFdWb1LFk5lpBov8Y6Pzu30ahHhOlZc9T3+aaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513446; c=relaxed/simple;
	bh=bfWSdTaFqm3U6HvBQIYhjmVtU+1wJZGXX8OMCPz1XQs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a2RXPzGGqgbSi07kfpLauL6+b+Wt5yYWrF801hJcW22g46lmp5Bhze7v7uzCvyhpnrl7vfpg0xRzWKDyYGr5rYT8ojmSUfOOG8hZ5E4uy4TSwPJ3WJaRIrTxyON3UtIiNvAMA+kgt8+LroSE2SoD42I6bqd1lJdlOwDaAfWonOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p1jNcbiO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3yCDbnGd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hUFxvmFffo/AQpwWPKnpCPqFu0D7gTHvei2vvdJy64=;
	b=p1jNcbiOb64M1fLzZuzZeUSx/dMHGRYvikoLoFbzJSEw4s1huyxGBJ/U8Jiby7fQC2tGxL
	jxPose5fIXqsmRY7Nh9OSWsXDbkshsLwqbHlmR+FkVYG7pDUY1S55PTV+Lnr8n3jfZsABm
	HmK4rkB7WnQ18z+Z58Gw5JpfHP5DzsrKlXQ3ZhHEc54XxfOdrYhaTIQecAhhl+WHdAOddG
	DBB9HRdtZHGWwMT3QPxpF41//bgGnbxbzfDbKHcOvwtOtXblL2OnX0Sh+Zf1ksEMGzI3tr
	Qlnp2Twpoff6VUQFIk9MrefKer+F10/MnufpL3KO9sWOGE1tbm6serxjh4Np3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hUFxvmFffo/AQpwWPKnpCPqFu0D7gTHvei2vvdJy64=;
	b=3yCDbnGdFiItfeC4ENgZ5CBMxBwNWJCgJhGWzsfYaxz8NvvbdwV6d9r0cM8btcrTtggjN9
	QrUfBOvTwYX7KHDg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86: Use macros to replace magic numbers in attr_rdpmc
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114011750.350569-7-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851344224.510.2809933077348414459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8c74e4e3e0596950554962229582260f1501d899
Gitweb:        https://git.kernel.org/tip/8c74e4e3e0596950554962229582260f150=
1d899
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 14 Jan 2026 09:17:49 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:27 +01:00

perf/x86: Use macros to replace magic numbers in attr_rdpmc

Replace magic numbers in attr_rdpmc with macros to improve readability
and make their meanings clearer for users.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260114011750.350569-7-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/core.c       | 7 ++++---
 arch/x86/events/intel/p6.c   | 2 +-
 arch/x86/events/perf_event.h | 7 +++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0ecac94..c2717cb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2163,7 +2163,8 @@ static int __init init_hw_perf_events(void)
=20
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
=20
-	x86_pmu.attr_rdpmc =3D 1; /* enable userspace RDPMC usage by default */
+	/* enable userspace RDPMC usage by default */
+	x86_pmu.attr_rdpmc =3D X86_USER_RDPMC_CONDITIONAL_ENABLE;
=20
 	for (quirk =3D x86_pmu.quirks; quirk; quirk =3D quirk->next)
 		quirk->func();
@@ -2643,12 +2644,12 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 		 */
 		if (val =3D=3D 0)
 			static_branch_inc(&rdpmc_never_available_key);
-		else if (x86_pmu.attr_rdpmc =3D=3D 0)
+		else if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_NEVER_ENABLE)
 			static_branch_dec(&rdpmc_never_available_key);
=20
 		if (val =3D=3D 2)
 			static_branch_inc(&rdpmc_always_available_key);
-		else if (x86_pmu.attr_rdpmc =3D=3D 2)
+		else if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_ALWAYS_ENABLE)
 			static_branch_dec(&rdpmc_always_available_key);
=20
 		on_each_cpu(cr4_update_pce, NULL, 1);
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 6e41de3..fb991e0 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -243,7 +243,7 @@ static __init void p6_pmu_rdpmc_quirk(void)
 		 */
 		pr_warn("Userspace RDPMC support disabled due to a CPU erratum\n");
 		x86_pmu.attr_rdpmc_broken =3D 1;
-		x86_pmu.attr_rdpmc =3D 0;
+		x86_pmu.attr_rdpmc =3D X86_USER_RDPMC_NEVER_ENABLE;
 	}
 }
=20
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f7caabc..24a81d2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -187,6 +187,13 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
=20
+/* user space rdpmc control values */
+enum {
+	X86_USER_RDPMC_NEVER_ENABLE		=3D 0,
+	X86_USER_RDPMC_CONDITIONAL_ENABLE	=3D 1,
+	X86_USER_RDPMC_ALWAYS_ENABLE		=3D 2,
+};
+
 /*
  * Per register state.
  */

