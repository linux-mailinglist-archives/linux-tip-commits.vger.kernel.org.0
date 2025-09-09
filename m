Return-Path: <linux-tip-commits+bounces-6528-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60DCB4AAB4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465195E0CD3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C32D23A8;
	Tue,  9 Sep 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pDAgIdp4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hEr7v/pF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1381D6193;
	Tue,  9 Sep 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413863; cv=none; b=fh4E+/RVV4eZCHmtnq55RIrzzosr5zm7jcpmzt/mvNTKgciKgvwt6RXzJsX/piUOlvyw0zQdlYdAMDxxKXtX2YemsabPFvnuCgxA6bQjCP+A35nu1KFHF+gkEqkdGrCBbn3HTRrNqdd99KLvYWI8pbmn7VzC2etlNgR9X9X3Xjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413863; c=relaxed/simple;
	bh=og3ba4V/UBw8lcsoJgAGqAYtShjqaxCHxVZzxHKbj6E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A8BozeH+9w1zwIcBJmNSXUo+wUbVchCdIgKf5kgTrN73dZzS92+pVB7ZQIeA6XRkO+4aI7beqKZGjw33igwFxHHoGYCN42IKDY/3pwY3zE0F1ctdZJn1BoHr4Ls8Jxm2FjHBsk3vYkCDLEwzOmf+6PdfOXEuhfHoDCPlTQEWf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pDAgIdp4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hEr7v/pF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zaVpQ2Md8Yb+Ut3yypNoiet9K2dXMn00RJdVutbBoY=;
	b=pDAgIdp42T/Ugx8mCWTVC1QPFRWmTQjDxpXGLFmTJTZwOI6J5H3pPl+fqfqsjuWecvCWdo
	M7xfSlAN94k1E++2nXz8Ksm137Km5Lfhl6N/AWAKEIF0hR1RnqrQqsf1dxX3QeY5afNu0b
	pFh5FAUY/4YueDMM79yID/dFeZ01ar9Hpvi5UmTeP98rvs6BgFDHfBnc+OTEOyeBc3fSEl
	tRaZMWhNvs+AGIxv/1qz298rULzrmyHblGTL07PTlO+3oIp79w77SaGF78ptz4/vUf7It/
	5EfXQNnE2xgBfd1i/4UHjAtWunzs+nbnTRYZBP29IXB6UzwKdFN74Pa4EtutLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zaVpQ2Md8Yb+Ut3yypNoiet9K2dXMn00RJdVutbBoY=;
	b=hEr7v/pFNHqXCcDQgWTyMz5l58lLf9OP928d9V1faQVGn5x3cyLOuQyrdDtBo0+GLZJN/h
	8/0+KsWEaF1hN4BQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] hrtimer: Reorder branches in hrtimer_clockid_to_base()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-9-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-9-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741385877.1920.7730377797893054997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3c3af563b31766f67106c7549ad084a08ef613f2
Gitweb:        https://git.kernel.org/tip/3c3af563b31766f67106c7549ad084a08ef=
613f2
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:18 +02:00

hrtimer: Reorder branches in hrtimer_clockid_to_base()

Align the ordering to the one used for hrtimer_bases.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-9-3ae8=
22e5bfbd@linutronix.de


---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index fedd1d7..f383df2 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1567,10 +1567,10 @@ u64 hrtimer_next_event_without(const struct hrtimer *=
exclude)
 static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 {
 	switch (clock_id) {
-	case CLOCK_REALTIME:
-		return HRTIMER_BASE_REALTIME;
 	case CLOCK_MONOTONIC:
 		return HRTIMER_BASE_MONOTONIC;
+	case CLOCK_REALTIME:
+		return HRTIMER_BASE_REALTIME;
 	case CLOCK_BOOTTIME:
 		return HRTIMER_BASE_BOOTTIME;
 	case CLOCK_TAI:

