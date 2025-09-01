Return-Path: <linux-tip-commits+bounces-6397-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F470B3E717
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 16:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557407A29F6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A6342CA1;
	Mon,  1 Sep 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0l5EBm6P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+3mkOR1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48D34165E;
	Mon,  1 Sep 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736897; cv=none; b=Hx8UG53wmpdrsnhqGH3xzKm9KsNjX419OKaRgGGFrTsH55fOELQ73AagVnmnSJy1sYbR73XFcSUyhaRyIdXPo0+JSTWfOpT0zgqbXkwhCisdE3p9eqPtNUOHXL3Lk4FCJnvbZXbpMj5YvqZyZfeefXQNE7ZuHJC0HojJDOXTfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736897; c=relaxed/simple;
	bh=ayq1Za+VNOdzru590hE9I3+caai7R6ud4Y6At/PMTWY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z/X+E6EPvSRTq3TX4Om08lJTSqaInE1d/8rzl+SR2WfqzoTP4oZfVUe/W1DPGSwqiP1UNlw1F6FT5mm+wd89dqrY/LUFRW6xSsxzeFHsPf2b309sqMGvIRsk5amhjkFN3LWYDlIgTH/ulZtDO9gHsB37o1hIWZ17B+gATQU+21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0l5EBm6P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E+3mkOR1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Sep 2025 14:28:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756736893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xps7HlmJBFzrdTfnKky1zeg/+KOUHgTGrw7shEZ8n4E=;
	b=0l5EBm6PC2OGxhFC4r4xNUYhKoAg2rj8qugdAoCNXkzz4uShjT7WWv6o7mqchMHN5QPvGz
	vrTA9IpXRduVM7kg8SvWugTJoCo0iP6xI8r5UvzMIoCQ5e+4RTXlPEBdR1M74W5j6zgtig
	YGEBuPOyY1lteEORLssYsAb+ggCrYqIDIecBeDOHrLn/s8dyh5dekA0dnk8A9NqevSwx2i
	jIzjIazRi6OHsK7nokh2dNx6ADSInUuZ6DkryDEeLp1gzob0kHIaI2yLTxRPKD2bIE+J89
	NJtpWU5ox7E5i0dP+gLg/DAIHNHQBS/ZfkZXcjzjKfPSJ4mMpN81ZuLMWFjyEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756736893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xps7HlmJBFzrdTfnKky1zeg/+KOUHgTGrw7shEZ8n4E=;
	b=E+3mkOR1+YGaIctoxi0LoZB5uEvxjeAfhqVuvkP9oWcv+Y1W/84Vs9CVLG5ZGb5uyfvtXn
	cyN/GWqdUXE2mrCg==
From: "tip-bot2 for Nai-Chen Cheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Fix format-security warnings in
 futex_priv_hash
Cc: "Nai-Chen Cheng" <bleach1827@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250827130011.677600-4-bigeasy@linutronix.de>
References: <20250827130011.677600-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175673689237.1920.5397597074920572070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     f8ef9c24029c85cd0328a9c668283017d8c292ad
Gitweb:        https://git.kernel.org/tip/f8ef9c24029c85cd0328a9c668283017d8c=
292ad
Author:        Nai-Chen Cheng <bleach1827@gmail.com>
AuthorDate:    Wed, 27 Aug 2025 15:00:09 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 16:20:08 +02:00

selftests/futex: Fix format-security warnings in futex_priv_hash

Fix format-security warnings by using proper format strings when passing
message variables to ksft_exit_fail_msg(), ksft_test_result_pass(), and
ksft_test_result_skip() function.

Thus prevent potential security issues and eliminate compiler warnings when
building with -Wformat-security.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250827130011.677600-4-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 10 +++----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index ec032fa..ffd60d0 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -192,10 +192,10 @@ int main(int argc, char *argv[])
 	futex_slots1 =3D futex_hash_slots_get();
 	if (futex_slots1 <=3D 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
-		ksft_exit_fail_msg(test_msg_auto_create);
+		ksft_exit_fail_msg("%s", test_msg_auto_create);
 	}
=20
-	ksft_test_result_pass(test_msg_auto_create);
+	ksft_test_result_pass("%s", test_msg_auto_create);
=20
 	online_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS + 1);
@@ -236,11 +236,11 @@ retry_getslots:
 			}
 			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
 				       futex_slots1, futex_slotsn);
-			ksft_exit_fail_msg(test_msg_auto_inc);
+			ksft_exit_fail_msg("%s", test_msg_auto_inc);
 		}
-		ksft_test_result_pass(test_msg_auto_inc);
+		ksft_test_result_pass("%s", test_msg_auto_inc);
 	} else {
-		ksft_test_result_skip(test_msg_auto_inc);
+		ksft_test_result_skip("%s", test_msg_auto_inc);
 	}
 	ret =3D pthread_mutex_unlock(&global_lock);
=20

