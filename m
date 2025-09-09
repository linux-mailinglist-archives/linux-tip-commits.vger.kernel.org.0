Return-Path: <linux-tip-commits+bounces-6517-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C7B4A677
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3A6188874C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C4627F4D5;
	Tue,  9 Sep 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X3SID/Bv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rVwO/aBX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16758279DAE;
	Tue,  9 Sep 2025 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408563; cv=none; b=hgNt6Uc7b/mXh4RIzxrhoCdE3kT+8UDEPzEht5YHWdt0Zt6M5HZb+/cBFytX9vFn5M8XJzaHsVrueqym9vBD1INm0lb/rOWXPATh1PjQ0jwsTZ+iAVDXVNKtfoZ13xlTkqwS4LN2H5RS+YrtMtJd6b9gXxWNjmsAeOD2tGLOP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408563; c=relaxed/simple;
	bh=aZ4uS8O1XNDJI9GG9xJJkajJwGQ+evq8gTy0oGAvaZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HoPjqaxdniRfCMPI4/Lw69MMHaoxsTstu6gJEIzUOfckwm7YrV1OnXzUosnGEx5PnzD1FJXF2Hm+gDUTZ9vlUj5ZJZsDWk8GLgOEpQRFI/eB90uxsYUuSKA47LjxMPyxnzvT/IZea2eZqKbsWe6MlE1wiHOSiq4l8c1wQ4ZFPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X3SID/Bv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rVwO/aBX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:02:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DloX5lrUP+E4MfUeUhaIYhXf3Fitm6QiFVZLfyO7Pnw=;
	b=X3SID/BvL1wXEmZnPx2KPH6uk5ik3wOe1Xshqf5SgggNjf5TiLvPybYji1kCt8m91nUBDW
	wiSumDQl8zrflXqRds8MHsy2agHYFJlWrqGmXhZjv2cTaKlPXVtK0ESr5CtTQcO69Klz50
	nFxNtSpIo0yL2hYlqxKcPDQ64WqvBnaLjGqpk2NSLvl7seL5zojNfKv5UXD/0FCg+WiFmg
	qb3frLhzg/WmH4tAi28euBfNOISHx5yhu76R5dRmKjHWL/Mc0kP3Q6Jl+Lsha7JgryW1eN
	Wy7/taY0y4FzAKD4zLHeNdHYHJUzvU+g2XCYVd4j/uXfS9WwGLkCKCxh5qqaMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DloX5lrUP+E4MfUeUhaIYhXf3Fitm6QiFVZLfyO7Pnw=;
	b=rVwO/aBXCqJBcnfGB4XQkFqGJV7RlLWAh7AuyOmyvO49wNpEflpLcfNT4GIzhe+L6M8vIT
	BNltSlEFqwlWGGDA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] selftests: vDSO: vdso_test_abi: Use ksft_finished()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250812-vdso-tests-fixes-v2-3-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-3-90f499dd35f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740855901.1920.5684976743047840347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     3afe371d322cdebc6338bbc121cca6944b6c7f2d
Gitweb:        https://git.kernel.org/tip/3afe371d322cdebc6338bbc121cca6944b6=
c7f2d
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 07:39:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:57:39 +02:00

selftests: vDSO: vdso_test_abi: Use ksft_finished()

The existing logic is just an open-coded ksft_finished().
Replace it with the real thing.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-vdso-tests-fixes-v2-3-90f499dd35f8=
@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/sel=
ftests/vDSO/vdso_test_abi.c
index 67cbfc5..b989167 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -231,6 +231,5 @@ int main(int argc, char **argv)
=20
 	vdso_test_time();
=20
-	ksft_print_cnts();
-	return ksft_get_fail_cnt() =3D=3D 0 ? KSFT_PASS : KSFT_FAIL;
+	ksft_finished();
 }

