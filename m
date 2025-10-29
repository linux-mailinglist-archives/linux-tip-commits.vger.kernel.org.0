Return-Path: <linux-tip-commits+bounces-7045-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84987C1965E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDB1421B90
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EB332C954;
	Wed, 29 Oct 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hRg1gid";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KTEtBau8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F85330310;
	Wed, 29 Oct 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730584; cv=none; b=SbCrHgg53/yiiOadAYkp5h4DDed2kQd847qcW0oQRK/1c9jnSGF15hmVnvNFB0VWieXin/TxL0dZWKWaI8r5gbrjL8Z3OmgOfpdHWSuyz8la7YlmwxSv1MerP/PJCTIeG2aQJ94vtq4BRFXopwFc70ER76TbkWAwL7pIiRV1wCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730584; c=relaxed/simple;
	bh=avb6spWt3gRFKp9T4WZ6Vto89JL9Op9jfqSg6ohIiu4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KnDd1BLbq+NwBNAQIYUskhoFUHntg6/QdrEGIGi7ifzwdN8aBPX/wlYW4UxYdBrs6mdpRnr/Oq9Io7JIjFRKJJBPcncsnEHeCUDu5zy0YvsvZdIm4dPm9KPYpNpe1CwHS90JU/NsJpyaLzW6JJqYZLZUA9HqfAyZXXo1a+0yy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hRg1gid; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KTEtBau8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI2KmtbbMnmmkt7mO2L0c+JzL8mjK4HysNMDmG2cNW4=;
	b=1hRg1gidy1LckfhCqqqUMbAqXEGr96eyJoFdPhYwsMlDj8BhLflirD1OBoG1cQ+1thu216
	m+CuE9xWX9SJQwqHaVN9qO4b/WdTnxSQQbz9KHOfAqeivlTAYgh6XnDrOvPhAHk7RBUKDR
	bJeiao258SfjTinJTCYbBYT0bLVwvluE2s5i0ImdLN4t57b3V7m9WUlFBYPMmM5tV2sNxR
	cRwiCkA+8nM3vwNyawAVgg8tuT5Seog7hE4Ys21MgvaLpuH/FaIKz0D6qtZU/ngSE2Kxex
	RdumH+Lqremgic9HWn6YBWhwzx7n+LFPbo8QeBcPZW+56f2gmVQH4I3uQmNmtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI2KmtbbMnmmkt7mO2L0c+JzL8mjK4HysNMDmG2cNW4=;
	b=KTEtBau8lrTrhz91xiQKQcp5KT8fPdYyNeOod7EBQ2tLOvGR/vB5qO1nYCqZ7AK0KTtojO
	FwS8yluwIUU4GZDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind: Simplify unwind_reset_info()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080118.777916262@infradead.org>
References: <20250924080118.777916262@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173057929.2601451.653673305854375483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     52a1ec718b3eb6da29a76d05a662365a997139cc
Gitweb:        https://git.kernel.org/tip/52a1ec718b3eb6da29a76d05a662365a997=
139cc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 15:46:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:55 +01:00

unwind: Simplify unwind_reset_info()

Invert the condition of the first if and make it an early exit to
reduce an indent level for the rest fo the function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080118.777916262@infradead.org
---
 include/linux/unwind_deferred.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 25f4dff..196e12c 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -46,22 +46,22 @@ void unwind_deferred_task_exit(struct task_struct *task);
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info =3D &current->unwind_info;
-	unsigned long bits;
+	unsigned long bits =3D info->unwind_mask;
=20
 	/* Was there any unwinding? */
-	if (unlikely(info->unwind_mask)) {
-		bits =3D info->unwind_mask;
-		do {
-			/* Is a task_work going to run again before going back */
-			if (bits & UNWIND_PENDING)
-				return;
-		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
-		current->unwind_info.id.id =3D 0;
-
-		if (unlikely(info->cache)) {
-			info->cache->nr_entries =3D 0;
-			info->cache->unwind_completed =3D 0;
-		}
+	if (likely(!bits))
+		return;
+
+	do {
+		/* Is a task_work going to run again before going back */
+		if (bits & UNWIND_PENDING)
+			return;
+	} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
+	current->unwind_info.id.id =3D 0;
+
+	if (unlikely(info->cache)) {
+		info->cache->nr_entries =3D 0;
+		info->cache->unwind_completed =3D 0;
 	}
 }
=20

