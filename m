Return-Path: <linux-tip-commits+bounces-5968-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FBCAEFB87
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14904A54C9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE42798E1;
	Tue,  1 Jul 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A5QcaJWQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RgiRna/w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8C27933E;
	Tue,  1 Jul 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378360; cv=none; b=ki7jXeZhykwLaKN+2n66hZSw9L2k+Xe4oRcy8393bl9hubkpZskcEWE11dZIn+7SvAuFjfPEA/LD4CIA18wuMA93bM7om5jo+JxvtJGXbU5iCMBVgYi18QRHBR1APziL4vGn9ZEcUKDOXvi7mtH+yfV4wga0kHbmnftq+4WN1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378360; c=relaxed/simple;
	bh=fXUNcEs78YgJ4RO4MNuP8nW2t+4f8aKrNgyBiZ/4Be4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fGsIGcMcmKnly7K6kOsxT/XJ69IfV5jdMYCfA3UcAVnfA6X6ir/o16qWcIkuTMBt9LMRen/ITiws8N+XwWEvq9IrGAJfFUdR+MxPAfu0bBPNiTVf8cw/IVlz1mCUIZzX1dAiJFkikbVA33oEvCKYRrT7T+GvfqdeQQnyDggYLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A5QcaJWQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RgiRna/w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751378356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pMatDXhG/enNNZr2IFaPaLc8W4GmyJ0n9wPb5u+jwk=;
	b=A5QcaJWQs1Yo/1KArEIKsSWxCLcBXMSWrDjCpdgyR5cZkKyGJbIuLAFgvkZ5LZmceWaHVe
	gxERxHMhmpJnNphdG+0i6qEMOzmxfRQzm/Dk788B5HGx9x9obMVKu1K++qke2FYfXKRkt7
	+/1tOpAN5mG3rJBMkKtYWr9RW4Nufp4zE9EfexvSbVbny8SM5k02ESZusb9EOq+10bDftY
	m/AlmB4WLTe6PPzxbhrW9l9R+Xi23K7noZkz4iUVJGgfWyWi85vcHL579Af6EcSo+SLqK5
	+RZVoLFOWqKnux7EmS0sytztXzpx6M8vRwmg8P9hNZKyXZTd4zLfQnSsu2AJGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pMatDXhG/enNNZr2IFaPaLc8W4GmyJ0n9wPb5u+jwk=;
	b=RgiRna/wM6mhJQ/xIDnOjMBEdGjL05AnAOmAHg/EO31SVxPu1oUC8rKVa8n6mXx7i8Op6Y
	qEYhrXNHSUdbq8Bw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_correctness: Fix
 -Wstrict-prototypes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250611-selftests-vdso-fixes-v3-7-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-7-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137835504.406.4067019385762035812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     58265d6424c69daf32ed96288709b23f7538c3e2
Gitweb:        https://git.kernel.org/tip/58265d6424c69daf32ed96288709b23f753=
8c3e2
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 11 Jun 2025 12:33:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:50:42 +02:00

selftests: vDSO: vdso_test_correctness: Fix -Wstrict-prototypes

Functions definitions without any argument list produce a warning with
-Wstrict-prototypes:

vdso_test_correctness.c:111:13: warning: function declaration isn=E2=80=99t a=
 prototype [-Wstrict-prototypes]
  111 | static void fill_function_pointers()
      |             ^~~~~~~~~~~~~~~~~~~~~~

Explicitly use an empty argument list.

Now that all selftests a free of this warning, enable it in the Makefile.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250611-selftests-vdso-fixes-v3-7-e62e37a6=
bcf5@linutronix.de

---
 tools/testing/selftests/vDSO/Makefile                | 2 +-
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/=
vDSO/Makefile
index 06d7225..918a2ca 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,7 +12,7 @@ TEST_GEN_PROGS +=3D vdso_test_correctness
 TEST_GEN_PROGS +=3D vdso_test_getrandom
 TEST_GEN_PROGS +=3D vdso_test_chacha
=20
-CFLAGS :=3D -std=3Dgnu99 -O2 -Wall
+CFLAGS :=3D -std=3Dgnu99 -O2 -Wall -Wstrict-prototypes
=20
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS +=3D -lgcc_s
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/tes=
ting/selftests/vDSO/vdso_test_correctness.c
index 5fb97ad..da651cf 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -108,7 +108,7 @@ static void *vsyscall_getcpu(void)
 }
=20
=20
-static void fill_function_pointers()
+static void fill_function_pointers(void)
 {
 	void *vdso =3D dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);

