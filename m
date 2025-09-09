Return-Path: <linux-tip-commits+bounces-6514-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC3B4A668
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8627BA552
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0752797A1;
	Tue,  9 Sep 2025 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VibkFjWe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGT0VDBk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ECA2773DA;
	Tue,  9 Sep 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408561; cv=none; b=mMegdiUO9MKHrGpnKYBCT7lIOfCwOArDecCYPoKRdcqDtn5+cM9cqw1ALYNXRcy2AnEip8j5lxNSu803QlW5VaY8z4Z7y9Qc/MDMZU2Oh33VaUYy71lX3hpokfWj7YFCkZ3tCgr84HyeT24Pf/Ax0NgCQzGwzeWIWXa9GuER2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408561; c=relaxed/simple;
	bh=cOQXoQKmqGGLuHg0gEpI1Ov5gEqGGg1gWp90XyvCGYc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VNUt8fSh/p3AdfgbZ0SFjpJ6MI5htWYvdyD3xEHLBw0VXMO2g5tiKBaWDxqKdhPwXHMB5p3ZjuLNpirFIasBFrfqWujiZHU/kZeXg4CfSqtNtoqYlJo0OkxLFz7HYmzdHmFLNGAkzdJGH1sG7N8K8bYpD2cCm96PxlsIk7cXHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VibkFjWe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGT0VDBk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:02:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRyMqxLeIZeAaTbyc0hf8NjN50n9sLzdCZSqRvoJBFc=;
	b=VibkFjWe2c0oP0Jin9jdV89hwFnNj3a1sK9OEmDqKY/+GDXIQjPB3xDTWKhwoMVNldtvUJ
	2lBs0Tu/Jzqi4kdo157abLBPYC+ABFNUkfF3kYfHrCxl7DH+ayh7ywvxH3jWHOeQTiM4T7
	zS0xks78AX1u0iBzD6muSwx/v4GWhbETM3mFdzGQKlnaqiLBtordFZ4RIDixLY6/+LrLqv
	rFnodk3o+muHIwyje8alio+VoyWTxjpbIrvzvW6XKcqZqAb47ECouESOU9RcDNDuj0lf3E
	f0bVCwgi5AORDxy6cYHUJYlDbH425LJ/Rt34PbEgCBn4qSz+B+b4G8e4vufrfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRyMqxLeIZeAaTbyc0hf8NjN50n9sLzdCZSqRvoJBFc=;
	b=ZGT0VDBkShrCrt8EroDIM7hO2fcPopTW23JgWfEdSpqBpt1vFH8G86C9opgH6fK5tdldZp
	3nLudzr0CoMZf2Aw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] selftests: vDSO: vdso_test_abi: Test CPUTIME clocks
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250812-vdso-tests-fixes-v2-6-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-6-90f499dd35f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740855545.1920.3522058548298646884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7b87dbf9d8465ad437cd7efacc26215b2c189607
Gitweb:        https://git.kernel.org/tip/7b87dbf9d8465ad437cd7efacc26215b2c1=
89607
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 07:39:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:57:39 +02:00

selftests: vDSO: vdso_test_abi: Test CPUTIME clocks

The structure is already there anyways, so test the CPUTIME clocks, too.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-vdso-tests-fixes-v2-6-90f499dd35f8=
@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/sel=
ftests/vDSO/vdso_test_abi.c
index a9a65f0..c25f099 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -175,7 +175,7 @@ static inline void vdso_test_clock(clockid_t clock_id)
 	vdso_test_clock_getres(clock_id);
 }
=20
-#define VDSO_TEST_PLAN	16
+#define VDSO_TEST_PLAN	20
=20
 int main(int argc, char **argv)
 {
@@ -204,6 +204,8 @@ int main(int argc, char **argv)
 	vdso_test_clock(CLOCK_MONOTONIC);
 	vdso_test_clock(CLOCK_MONOTONIC_RAW);
 	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+	vdso_test_clock(CLOCK_PROCESS_CPUTIME_ID);
+	vdso_test_clock(CLOCK_THREAD_CPUTIME_ID);
=20
 	vdso_test_time();
=20

