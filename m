Return-Path: <linux-tip-commits+bounces-5967-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F851AEFB90
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75B01892CCD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166642797B5;
	Tue,  1 Jul 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mkPvZI/R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8I8p3sE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E20279334;
	Tue,  1 Jul 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378360; cv=none; b=HHGztcYOcg5JGsQCfJ+nU1h3gxmiqBU/kFYNOE/RiW/WruTZVE0GLGz/RJOV7HO9I8ARn1xCVAH3VC2qrc87b10l6nsv2ZhbEpBfr+kmllurxhYIHK17lIJsQ0rPZ+SfJjmoOHy/JK/5SuYX7TRa/UEQ9Z0c0nnWfqDwHVJoT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378360; c=relaxed/simple;
	bh=WTDP+8lG3uVDLQGcyaQmYXpWO/jeFtKOWvcLO39OuwA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eUILbiUj6vgjI/lZBRKWlfydPlOJb3AHI9pmAO9Q72blMFdNDbxzAJuvsnxoxWEEbwFjpUw4gw7P/fFi4tMa/+OkQAFQUBMEePVOI/QZbapLxSJsWraMAi1eSoDnRvaQ9fIcN4Vob4UUxocjYOOF+qHBTdG63fz37bsyX98dJ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mkPvZI/R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8I8p3sE; arc=none smtp.client-ip=193.142.43.55
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
	bh=1+YUndEULoMhbA8XXEOYeGrd8eWmA++uQ9DEBHYQHMU=;
	b=mkPvZI/R8odWQyGc00GRH2sgjulqvHrS9R9tEQmoyPUCD6inotVTUyBg8NSGzsnCrLxIu1
	jVSpyJATb3iJO2htAe26eikXueeHJMr6WndyIrhsCbfWbrIkS5lc/DOjeI/ZGy6dY1QIkm
	9XC4oQxIfEWO2hSplWck7G4ONf0vAXcZARdyalbbirdjz8fqf2ogG0MHuMiGJUPc8i6BTg
	R+Cvm9K85LKXuL8E1LFWgKlQqovF0Nn45BfLxrQV5b840Dq7uWJGS017I9AxRzY+CvuFmE
	PBwQBA2BbHTQjQF5/SeK7ggK0OuPnXz8yOWy2fPGhliKO0Vj+gZegNazOaQrCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+YUndEULoMhbA8XXEOYeGrd8eWmA++uQ9DEBHYQHMU=;
	b=N8I8p3sE9Irex6mPm5BAWPxO1RPilo2GTOEgvjpVsLagunYph/fTqlQ7HozuKw95t85BXl
	VrRKJzOLLa0SkLDA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: Enable -Wall
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250611-selftests-vdso-fixes-v3-6-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-6-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137835591.406.12879102679783540.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     8863cd78a0f10b5b81ca91a558b7e70bcb66e859
Gitweb:        https://git.kernel.org/tip/8863cd78a0f10b5b81ca91a558b7e70bcb6=
6e859
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 11 Jun 2025 12:33:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:50:42 +02:00

selftests: vDSO: Enable -Wall

Protect against common programming errors through compiler warnings.
These warnings are also used for the kernel itself.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250611-selftests-vdso-fixes-v3-6-e62e37a6=
bcf5@linutronix.de

---
 tools/testing/selftests/vDSO/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/=
vDSO/Makefile
index 12a0614..06d7225 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,7 +12,7 @@ TEST_GEN_PROGS +=3D vdso_test_correctness
 TEST_GEN_PROGS +=3D vdso_test_getrandom
 TEST_GEN_PROGS +=3D vdso_test_chacha
=20
-CFLAGS :=3D -std=3Dgnu99 -O2
+CFLAGS :=3D -std=3Dgnu99 -O2 -Wall
=20
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS +=3D -lgcc_s

