Return-Path: <linux-tip-commits+bounces-4191-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA5AA5F27B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E21E18846CB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF4A267B02;
	Thu, 13 Mar 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tsx8shnQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dx/nl70"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F326772A;
	Thu, 13 Mar 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865496; cv=none; b=fb+lIis+tsv7dcy3eRU9YxFmX8AONgf3Y1nhfOwgBHAqTvk7qWXCLrSW4a5oK2F+IGEXqOUB3jl3aFWNZJzKjPd8l0EUVOLP7/cWrzW85u4lD9mF8sUEmbhuxW97iT2rSxRw6zaQAttWaUx/h6PSsnqN4nqBfvNTzEISRyWWk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865496; c=relaxed/simple;
	bh=8tGWCRF9lQ551v9I94tGteWPqZcktmOde9fEqVCvgQY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uWfbn4K6uv46/sPlhmrHY/DlgKlobyaKZb5eCg73dUjqhyfRYFVYAQ597LL4rhqmBIm6ok+exsOXToSIqmWobvBA8O+78gGb7fapHUuxOmPDI63ic8GdxCtB8Xai+BoAPq0+m9YvKnJL98/WRXPMqe/37tG5M0UIbLgqnffhGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tsx8shnQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dx/nl70; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHjxreHYUsU3KezqDXlSMuZXg55c3Vi5NEbaT4X4XNo=;
	b=tsx8shnQ0yQ/K1RVFYVJxldCBrCoOSre62pMkHotK4l59tjkYQ8hQkuu23r0fb/CVIYsY+
	pNt1rmnAC6Rera9BMGsyuiGXVwgWXkXJolQ7ACRL7Rkv7NouYH6iovFcY/OsbYei67XbPc
	/1GeoGNjEkNursmmHNj95pHtQ/ev9UxL0vZI28wW34WGC77AoAxNQbdwg8PymEf929WAZT
	UkxijmZR0UV4Uwv4v8xs8ffsllDW5oCTmcgaYfrqyO96892KZZ0Ci3HcDYrM9oRbMc0pja
	R98Seh0Afr+b4eVwnNSubbkMpmJC3Zx5YLnGv062/fZ/12kmVwOyAa30Hr4bYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHjxreHYUsU3KezqDXlSMuZXg55c3Vi5NEbaT4X4XNo=;
	b=9dx/nl70Q+Jp3iOpui5JUfEaAxOM8O7U6RVogZEAeRdJR+Cg0adlwgxR3TqNj7hLK7jmw1
	G0oKl9hC9Yq8zEBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Cleanup includes
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155623.701301552@linutronix.de>
References: <20250308155623.701301552@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186549292.14745.9560798914702393758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6ad9c3380ab03c6ff3217df48a02e851e9b03db7
Gitweb:        https://git.kernel.org/tip/6ad9c3380ab03c6ff3217df48a02e851e9b03db7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:16 +01:00

posix-timers: Cleanup includes

Remove pointless includes and sort the remaining ones alphabetically.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155623.701301552@linutronix.de


---
 kernel/time/posix-timers.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index de25253..e908846 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -9,28 +9,22 @@
  *
  * These are all the functions necessary to implement POSIX clocks & timers
  */
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/time.h>
-#include <linux/mutex.h>
-#include <linux/sched/task.h>
-
-#include <linux/uaccess.h>
-#include <linux/list.h>
-#include <linux/init.h>
+#include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/hash.h>
+#include <linux/hashtable.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/nospec.h>
 #include <linux/posix-clock.h>
 #include <linux/posix-timers.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
 #include <linux/syscalls.h>
-#include <linux/wait.h>
-#include <linux/workqueue.h>
-#include <linux/export.h>
-#include <linux/hashtable.h>
-#include <linux/compat.h>
-#include <linux/nospec.h>
+#include <linux/time.h>
 #include <linux/time_namespace.h>
+#include <linux/uaccess.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"

