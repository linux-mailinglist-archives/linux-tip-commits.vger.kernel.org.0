Return-Path: <linux-tip-commits+bounces-1430-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7053890B580
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 17:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F351F23BDB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B4014830B;
	Mon, 17 Jun 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vPTMJtGW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8YzIPf23"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D6146D7D;
	Mon, 17 Jun 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639244; cv=none; b=WOunvDUeZ409+9KP3lR5DPEOpgSRvpgIw5WH8SqupBHO6I3nb9Y6diebBT66gR38cqx/SPhuycUOH8LP1bnDm9Ovu/i9d5lrw6fVDE43bhTufbkN9wiuFQGvuYNW3YbdW3BF87W1dv+X5wNKRFIu/5q1QqANo02oO/ZMA6LyR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639244; c=relaxed/simple;
	bh=CLZ0PsmW5WMgzHk78pv8AZyBLgFcFiUl3pMhUjC8Myk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gQ3DyHAQ+Vg7DwDxJrWUbn9HJeegIvU08fMykNalDy8KgAT/spkZDxBHptgZ8Hwss3pYNAYL4Z7uCSfJip0xqznlDJ+HDRiCVkL3eUAkDn8HPc1Y+cDb3CDZwZz3dHzXyaofiF0R8eSRHkbSzLRniWa3/4alHAD3e+occM3UyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vPTMJtGW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8YzIPf23; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 15:47:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718639239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQITPBwTEBcq+q0iLYwM5WghNeRKmVHXjzAwruhZcos=;
	b=vPTMJtGWzhLD5AdpAYf5VrEDZUro+s/VmTLZLDv5CSfcwBrtUj0Qq7fmKWjLKsHzjAPel0
	7ZrRBBZewmZLFGOR3sX5i9dYP2L7sAZGhCv3US/1qPvuWsXLEL0ay9Q1JW8W2g0MbI8dPS
	DnY73t74ddSMXmhiRRW8NEJF9dTKUeuhSuL9lWOw/whoMm76DML4jJQgpCaN6euOOabwDT
	TQoK/xmkTDO9RSP5/YEyYbw6GdzmaaGb2P2zw43sxeL6vS2VoYMjqt/SpcEKWB2v665qxR
	fQSq2I2mOEnIGqF8nB7iGi+6te615QemqffOHy8KxHPGwdHNieHiNUsDgib2pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718639239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQITPBwTEBcq+q0iLYwM5WghNeRKmVHXjzAwruhZcos=;
	b=8YzIPf233HLgullHrUyYNKaPK7SxnGXDUNbh+xIlA7HfydFDSAUdUqObZLkppOzokl5p79
	/QeEYoLfEs67bkCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] perf/x86: Serialize set_attr_rdpmc()
Cc: Yue Sun <samsun1006219@gmail.com>, Xingwei Lee <xrivendell7@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610124406.359476013@linutronix.de>
References: <20240610124406.359476013@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863923937.10875.5031340765498792257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bb9bb45f746b0f9457de9c3fc4da143a6351bdc9
Gitweb:        https://git.kernel.org/tip/bb9bb45f746b0f9457de9c3fc4da143a6351bdc9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 14:46:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Jun 2024 11:25:22 +02:00

perf/x86: Serialize set_attr_rdpmc()

Yue and Xingwei reported a jump label failure. It's caused by the lack of
serialization in set_attr_rdpmc():

CPU0                           CPU1

Assume: x86_pmu.attr_rdpmc == 0

if (val != x86_pmu.attr_rdpmc) {
  if (val == 0)
    ...
  else if (x86_pmu.attr_rdpmc == 0)
    static_branch_dec(&rdpmc_never_available_key);

				if (val != x86_pmu.attr_rdpmc) {
				   if (val == 0)
				      ...
				   else if (x86_pmu.attr_rdpmc == 0)
     FAIL, due to imbalance --->      static_branch_dec(&rdpmc_never_available_key);

The reported BUG() is a consequence of the above and of another bug in the
jump label core code. The core code needs a separate fix, but that cannot
prevent the imbalance problem caused by set_attr_rdpmc().

Prevent this by serializing set_attr_rdpmc() locally.

Fixes: a66734297f78 ("perf/x86: Add /sys/devices/cpu/rdpmc=2 to allow rdpmc for all tasks")
Closes: https://lore.kernel.org/r/CAEkJfYNzfW1vG=ZTMdz_Weoo=RXY1NDunbxnDaLyj8R4kEoE_w@mail.gmail.com
Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: Xingwei Lee <xrivendell7@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240610124406.359476013@linutronix.de
---
 arch/x86/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07..acd367c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2547,6 +2547,7 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
+	static DEFINE_MUTEX(rdpmc_mutex);
 	unsigned long val;
 	ssize_t ret;
 
@@ -2560,6 +2561,8 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 	if (x86_pmu.attr_rdpmc_broken)
 		return -ENOTSUPP;
 
+	guard(mutex)(&rdpmc_mutex);
+
 	if (val != x86_pmu.attr_rdpmc) {
 		/*
 		 * Changing into or out of never available or always available,

