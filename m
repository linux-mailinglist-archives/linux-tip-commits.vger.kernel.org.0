Return-Path: <linux-tip-commits+bounces-5973-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A948CAEFB9C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D0188D4FB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870A72820B1;
	Tue,  1 Jul 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6ZZm48W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="euDmIgEf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3145280A5A;
	Tue,  1 Jul 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378364; cv=none; b=OByh1IkR/BGd8xin9LcUptTYXSQA3kr2B7f/m2VnDVrbIp6P5Sws1vNtWW3z8RD8sW2Ky+lp7VWKSByoV8C07kWeEBKGwjLor3b7AFh7kTFwrkgV+m+UInjC6a2c2ShWFTf4yV6pVW/bL0XzkFs77A/aWzqMUTJ8jjkQZm77jWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378364; c=relaxed/simple;
	bh=c8dSGnUNXU55DITPFYnDvp20ner1x+QiCjzCEg+UgtY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IecFprlas4Krq20kuzFpbeXkaIhJIzygFDKg8IrWi+97DfifoFd+mVfeuxqkoIqwkVGE8kEhKj75p3jN2TOpLVBv5CY0GAHIxBkyY1XSLd5ixzSK+oiFLoVQT8bsf+ntho/iqGF2ftBDYtnFf5fUyI3cxtfbGK/JP5wggaW/Pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6ZZm48W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=euDmIgEf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:59:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751378361;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAzGYfbAz25rmhFD9owzDDP0ftvzKURn2nFibiWSSY0=;
	b=a6ZZm48WADY/iJJ8l5xm1mww3GjfXiwp3xEB7Q94wfb0Xj0G3Q0oA9Henkbp1+NBbvepHi
	1xaq26HDf2Fa0vnsprbyArynd32bypiWQklYypCK4Xf3E0UiOlkrQ3h5NLGjSYZRUydm4X
	Yis8icvNSWkSZvJMMDX3Hb/xZJOVq2ELZeGv92NK45hBUgr6//7C8vLlhE9sHp3AteqXBY
	hq+e8PA9UweLvsYBkvFvjoYp0Yy5zaTjwgktbOaeF3DhO0UI0N7Le8t/yd+KMib427cKDG
	o41dP2APcC+F0ibftuDG/PE1z2qiZ0qDDtECQhi84H3cRaKKquD+zGNl9WCy2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378361;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAzGYfbAz25rmhFD9owzDDP0ftvzKURn2nFibiWSSY0=;
	b=euDmIgEfyGKQKR1uFYiTGyvVI5YJu40rhpd2yngNqHRYjIoRf2ka26w6/JRS4nyrCRYc+O
	h6p3xc/R72enU3AA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] selftests: vDSO: chacha: Correctly skip test if necessary
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-selftests-vdso-fixes-v3-1-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-1-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137836029.406.15841768497290312533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     2c0a4428f5d6005ff0db12057cc35273593fc040
Gitweb:        https://git.kernel.org/tip/2c0a4428f5d6005ff0db12057cc35273593=
fc040
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 11 Jun 2025 12:33:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:50:41 +02:00

selftests: vDSO: chacha: Correctly skip test if necessary

According to kselftest.h ksft_exit_skip() is not meant to be called when
a plan has already been printed.

Use the recommended function ksft_test_result_skip().

This fixes a bug, where the TAP output would be invalid when skipping:

	TAP version 13
	1..1
	ok 2 # SKIP Not implemented on architecture

The SKIP line should start with "ok 1" as the plan only contains one test.

Fixes: 3b5992eaf730 ("selftests: vDSO: unconditionally build chacha test")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/all/20250611-selftests-vdso-fixes-v3-1-e62e37a6=
bcf5@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/=
selftests/vDSO/vdso_test_chacha.c
index 8757f73..0aad682 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -76,7 +76,8 @@ static void reference_chacha20_blocks(uint8_t *dst_bytes, c=
onst uint32_t *key, u
=20
 void __weak __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint32_=
t *key, uint32_t *counter, size_t nblocks)
 {
-	ksft_exit_skip("Not implemented on architecture\n");
+	ksft_test_result_skip("Not implemented on architecture\n");
+	ksft_finished();
 }
=20
 int main(int argc, char *argv[])

