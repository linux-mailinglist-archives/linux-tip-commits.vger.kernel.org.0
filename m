Return-Path: <linux-tip-commits+bounces-7165-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6ECC28782
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78FE04EE972
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1BE3148CD;
	Sat,  1 Nov 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fI9QFPbz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDZrEuLY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585983043D2;
	Sat,  1 Nov 2025 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026500; cv=none; b=aV4v6OKq2Li32ENHjtVWTYT/+agRtPSU7tVvco1Xvzqcz9P6asK+5yD84rkTIszJbeoiyE8ihYfGsUlrQO/DOqpf4BQLZg7/eKU0GM2a/l197Dw4P00flq3bskCZDVMQ/nSkC9ZxilFBwK6pwbhk5JwPCbwsibxHRmUylnT07W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026500; c=relaxed/simple;
	bh=9LMYGJ9brPFNYJWm9Gq652MUpRfHMEpRHUzUVtxIMxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XuOwtRplKpPpoJAB5BiHAxLX+ZlyVuHqdOz8VCJvSrS3BiYUJPewAIiSK/bHpiFb7X0AFQYUVrQKj9S33Q8tzJNp8RY1JxCKciRHcmLcEFqS0ouySGrg5ahpEs10Ia7EuGjH8ErP2fE38uTEjS2xqmt3BU0QtHKWOXApfqo5SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fI9QFPbz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDZrEuLY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwi4Tk1dKWYNjlLvL3IyZPoAGLT44v4YhzCJGIDpmAg=;
	b=fI9QFPbzU7urr1ZL1CbQ/5mwXyKPfcBGjFy6WXZQyiV0njFVEdo0b+AwxpSXbA9i2ri+hU
	ZRYeMWBKDH6wo/+bvGwyHNGqsStXpIgufWlSn7oeLr97p8eL6TwF2CFVhQKX1WtVv3DeBg
	fK61bzjjmZff9QKVKsDRnrBIaa3RFLtyIKZZFwSYdwtO90V/ZJXaTfmN69/AHBp3sbjwjB
	tPQQEVW40iD/KI7mwaiGveowv/kyKMWlDpb8629fhUqo0uI1a3Pc9CfYNZWUYETWSUtyfv
	l+kicpiMoHUFXEr0sR30Lp+5Lmxte6rXQAUAgO92p8QZAns0IEKfCnbVkfVwzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwi4Tk1dKWYNjlLvL3IyZPoAGLT44v4YhzCJGIDpmAg=;
	b=aDZrEuLYtDH2M7EV/18ienoi21oA4/ZFnxFyxzbyauBvrNj++/SnFkNW3hNfEXRiMp+ekB
	8MZwHOyFJ2Uda9Dw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_correctness: Handle
 different tv_usec types
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-1-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-1-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202649558.2601451.3315485299845584781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     eca893b27b9e8c385dc06e9b42dc14203978cd38
Gitweb:        https://git.kernel.org/tip/eca893b27b9e8c385dc06e9b42dc1420397=
8cd38
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:02 +01:00

selftests: vDSO: vdso_test_correctness: Handle different tv_usec types

On SPARC the field tv_usec of 'struct timespec' is not a 'long int', but
only a regular int. In this case the format string is incorrect and will
trigger compiler warnings.

Avoid the warnings by casting to 'long long', similar to how it is done for
the tv_sec and what the other similar selftests are doing.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-1-e0607bf49=
dea@linutronix.de
---
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/tes=
ting/selftests/vDSO/vdso_test_correctness.c
index da651cf..5229fca 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -412,10 +412,10 @@ static void test_gettimeofday(void)
 		return;
 	}
=20
-	printf("\t%llu.%06ld %llu.%06ld %llu.%06ld\n",
-	       (unsigned long long)start.tv_sec, start.tv_usec,
-	       (unsigned long long)vdso.tv_sec, vdso.tv_usec,
-	       (unsigned long long)end.tv_sec, end.tv_usec);
+	printf("\t%llu.%06lld %llu.%06lld %llu.%06lld\n",
+	       (unsigned long long)start.tv_sec, (long long)start.tv_usec,
+	       (unsigned long long)vdso.tv_sec, (long long)vdso.tv_usec,
+	       (unsigned long long)end.tv_sec, (long long)end.tv_usec);
=20
 	if (!tv_leq(&start, &vdso) || !tv_leq(&vdso, &end)) {
 		printf("[FAIL]\tTimes are out of sequence\n");

