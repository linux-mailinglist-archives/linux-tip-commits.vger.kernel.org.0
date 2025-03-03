Return-Path: <linux-tip-commits+bounces-3786-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19078A4BCB1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477891892286
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C691F560B;
	Mon,  3 Mar 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rP8olQju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PNpcFeSZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB031F462D;
	Mon,  3 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998590; cv=none; b=lNWV93JMRYa9FAvDsX9UTQG7g/IUGLA0+D/mJGLOK9AhntutMiDc+z3x8g9+9UH1C3kdjzdJW8mwY5ZIcQIUciFBzh7fmMlQcbspEda86yiUmtP9A+DYLdp9vuWqbRlpLu6QA3h2ZK+kJD8n+Jjro8wsl8wmnf70hOtknl8H7PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998590; c=relaxed/simple;
	bh=i5YWhBkmrF5xXH07S+agKTJnJBI+1+7IVU24C9+BOmM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ozYUS8uV7sQkk+O7D58gGIwtYcsOH/7vgiyrb5asBueQcCWAUBmBycNpfuZKAIvCBfUfrb40jaspVpBGDBrR4R7cQiThvKQ7ePYwrF6j3fHYQaIyyhXybjOvo2MCZklJQQNln2r3/e2/0mF42GWEiaz735EU+RGH/5GyUDS05HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rP8olQju; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PNpcFeSZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DffzsZO2kcnOWCEYAT88mKcoMZiIneZrmlbiz3l1QSs=;
	b=rP8olQjuJCwYXqumL/xYtfcRnHcG93InbK2KCKRptG1Ue2kwaDG+9P5pKii1D3gnwmse5w
	9PwULAMXdnmCktRZV545Acw4HRdmTMuSk5InGju8t3FBkHXB0QkQnq51wWYtkkMtaSEtSU
	rJiBl5HtBdtUTB3h3K4+I+tiuE9v73j0sKF+m0A9SEU2Jsc7J4hT6dJGqpOoUR5EkkFKSc
	BIMVdMEuFsE/2tloqkMloFyd8p8awxWD3ST5MHNXQWbHP4WY9OzLz8eP6g+az8fgX8nVho
	dSd3wJqymUTD/oYf3hAI1X8S1xj221nSUD9LyKdnlIHgu9aKcKHflxXycYD1Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DffzsZO2kcnOWCEYAT88mKcoMZiIneZrmlbiz3l1QSs=;
	b=PNpcFeSZPChsXunkWA9g6J6R4g5WBh4TJrYMJm1iKRtitrjoJqsxR7Mobf69POADIRf5Jw
	qW57kufzh6rTI/BQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Make vdso_time_data cacheline aligned
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858620.10177.4119971334794072658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     48313da79b19fc4943be7507473a3501cf73906c
Gitweb:        https://git.kernel.org/tip/48313da79b19fc4943be7507473a3501cf7=
3906c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:33 +01:00

vdso: Make vdso_time_data cacheline aligned

vdso_time_data is not cacheline aligned at the moment. When instantiating
an array, the start of the second array member is not cache line aligned.

This increases the number of the required cache lines which needs to be
read when handling e.g. CLOCK_MONOTONIC_RAW, because the data spawns an
extra cache line if the previous data does not end at a cache line
boundary.

Therefore make struct vdso_time_data cacheline aligned.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/vdso/datapage.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index ed4fb4c..dfd98f9 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -11,6 +11,7 @@
=20
 #include <vdso/align.h>
 #include <vdso/bits.h>
+#include <vdso/cache.h>
 #include <vdso/clocksource.h>
 #include <vdso/ktime.h>
 #include <vdso/limits.h>
@@ -126,7 +127,7 @@ struct vdso_time_data {
 	u32			__unused;
=20
 	struct arch_vdso_time_data arch_data;
-};
+} ____cacheline_aligned;
=20
 /**
  * struct vdso_rng_data - vdso RNG state information

