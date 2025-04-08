Return-Path: <linux-tip-commits+bounces-4751-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802EA81558
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334644E0E26
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC124394F;
	Tue,  8 Apr 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bk+Kv1o7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xd7epz2w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A51E8348;
	Tue,  8 Apr 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139103; cv=none; b=l4/d0UX2CjjETielyW8jZ2cl/rhv3bCw0N9gvThkXOw7llP+BCGG6jWcorL8cYbf7h2MatbeR4c/EBjxgm9qw3JFc6NH2GCVvXWud0Cjman0Q9aE+J1QksS4GImhH+eWVUjQShGVzUiCpZ+mO2FQDLNNZpbYcQvHq4HjAtOKZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139103; c=relaxed/simple;
	bh=Wn8e1MXp2UJdExf5JikiAb8wnn4BJ1y2vIBYO1I6Oxc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=antRbRTPTx9x3edP0jL4Srm6xA+/rtuJ3bfb5zrmYh3QWutdN568UQrnJ93NbAwXdtpSyPSsEDFOfnxZch6GOo3zZISgsIm+XKlGxVy/bUr7hXtfPjjjE/cuwE1qFpTdHdqJWdYSDyfishscr0HtUDYPB+j1De0cXHleKhYzsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bk+Kv1o7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xd7epz2w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:04:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/pnUEhm0DZbo6F3fSk+JoKEtcvEBcYobdMPXVcces8=;
	b=bk+Kv1o78uLQTUeOiK2VqowNiNlC1hoS+dH1E7I+NAGs+aOoH8gjsJgJzVD0AK+OC7hgqm
	UDzSgQ07KVsc7ZYHGXBVPQ3IrpCj78oWvHbXFiPwWRN/gE/8/YfoenEaYeQ3KNs9oILUIl
	CiEm5zcEpe/emBvoVCCDvjqBqcOhrBoByGtrbVf527UFyMZLGxjX5e2yvuGXsMNYQlZZKh
	wD85IlFeMgl/2IZCHaMLPU18unBC/uCOnsVMoRFZNuu4Jw4rqcAbZZ+QF0PkNKRuIGzqhC
	9LcnHMICg7J5QbBAh9Eb44ylht/Xj4zXFOHnJ96iee1MCF7B3FYVB8jvMCmMgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/pnUEhm0DZbo6F3fSk+JoKEtcvEBcYobdMPXVcces8=;
	b=xd7epz2wZa25ImH8d2PppeMGcRBHcdcZzvLtHKjtOLs4Y0XK03FOhxs838QyNmjbkbpQWZ
	R0WHl7yQyGRFLQAA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Extend the bit width of the arch-specific flag
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Falcon <thomas.falcon@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327195217.2683619-4-kan.liang@linux.intel.com>
References: <20250327195217.2683619-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413909831.31282.3118773367374848387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c9449c8506a5df5052ef4d17867699517b10b55a
Gitweb:        https://git.kernel.org/tip/c9449c8506a5df5052ef4d17867699517b10b55a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 27 Mar 2025 12:52:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:49 +02:00

perf: Extend the bit width of the arch-specific flag

The auto counter reload feature requires an event flag to indicate an
auto counter reload group, which can only be scheduled on specific
counters that enumerated in CPUID. However, the hw_perf_event.flags has
run out on X86.

Two solutions were considered to address the issue.
- Currently, 20 bits are reserved for the architecture-specific flags.
  Only the bit 31 is used for the generic flag. There is still plenty
  of space left. Reserve 8 more bits for the arch-specific flags.
- Add a new X86 specific hw_perf_event.flags1 to support more flags.

The former is implemented. Enough room is still left in the global
generic flag.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Link: https://lkml.kernel.org/r/20250327195217.2683619-4-kan.liang@linux.intel.com
---
 arch/x86/events/perf_event_flags.h | 41 ++++++++++++++---------------
 include/linux/perf_event.h         |  2 +-
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 1d9e385..7007833 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -2,23 +2,24 @@
 /*
  * struct hw_perf_event.flags flags
  */
-PERF_ARCH(PEBS_LDLAT,		0x00001) /* ld+ldlat data address sampling */
-PERF_ARCH(PEBS_ST,		0x00002) /* st data address sampling */
-PERF_ARCH(PEBS_ST_HSW,		0x00004) /* haswell style datala, store */
-PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
-PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
-PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
-PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
-PERF_ARCH(PEBS_CNTR,		0x00080) /* PEBS counters snapshot */
-PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
-PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
-PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
-PERF_ARCH(PEBS_VIA_PT,		0x00800) /* use PT buffer for PEBS */
-PERF_ARCH(PAIR,			0x01000) /* Large Increment per Cycle */
-PERF_ARCH(LBR_SELECT,		0x02000) /* Save/Restore MSR_LBR_SELECT */
-PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
-PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
-PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
-PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
-PERF_ARCH(NEEDS_BRANCH_STACK,	0x40000) /* require branch stack setup */
-PERF_ARCH(BRANCH_COUNTERS,	0x80000) /* logs the counters in the extra space of each branch */
+PERF_ARCH(PEBS_LDLAT,		0x0000001) /* ld+ldlat data address sampling */
+PERF_ARCH(PEBS_ST,		0x0000002) /* st data address sampling */
+PERF_ARCH(PEBS_ST_HSW,		0x0000004) /* haswell style datala, store */
+PERF_ARCH(PEBS_LD_HSW,		0x0000008) /* haswell style datala, load */
+PERF_ARCH(PEBS_NA_HSW,		0x0000010) /* haswell style datala, unknown */
+PERF_ARCH(EXCL,			0x0000020) /* HT exclusivity on counter */
+PERF_ARCH(DYNAMIC,		0x0000040) /* dynamic alloc'd constraint */
+PERF_ARCH(PEBS_CNTR,		0x0000080) /* PEBS counters snapshot */
+PERF_ARCH(EXCL_ACCT,		0x0000100) /* accounted EXCL event */
+PERF_ARCH(AUTO_RELOAD,		0x0000200) /* use PEBS auto-reload */
+PERF_ARCH(LARGE_PEBS,		0x0000400) /* use large PEBS */
+PERF_ARCH(PEBS_VIA_PT,		0x0000800) /* use PT buffer for PEBS */
+PERF_ARCH(PAIR,			0x0001000) /* Large Increment per Cycle */
+PERF_ARCH(LBR_SELECT,		0x0002000) /* Save/Restore MSR_LBR_SELECT */
+PERF_ARCH(TOPDOWN,		0x0004000) /* Count Topdown slots/metrics events */
+PERF_ARCH(PEBS_STLAT,		0x0008000) /* st+stlat data address sampling */
+PERF_ARCH(AMD_BRS,		0x0010000) /* AMD Branch Sampling */
+PERF_ARCH(PEBS_LAT_HYBRID,	0x0020000) /* ld and st lat for hybrid */
+PERF_ARCH(NEEDS_BRANCH_STACK,	0x0040000) /* require branch stack setup */
+PERF_ARCH(BRANCH_COUNTERS,	0x0080000) /* logs the counters in the extra space of each branch */
+PERF_ARCH(ACR,			0x0100000) /* Auto counter reload */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 54dad17..5c54732 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -144,7 +144,7 @@ struct hw_perf_event_extra {
  * PERF_EVENT_FLAG_ARCH bits are reserved for architecture-specific
  * usage.
  */
-#define PERF_EVENT_FLAG_ARCH			0x000fffff
+#define PERF_EVENT_FLAG_ARCH			0x0fffffff
 #define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
 
 static_assert((PERF_EVENT_FLAG_USER_READ_CNT & PERF_EVENT_FLAG_ARCH) == 0);

