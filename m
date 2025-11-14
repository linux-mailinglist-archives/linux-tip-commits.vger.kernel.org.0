Return-Path: <linux-tip-commits+bounces-7347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D178C5D67D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 14:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A2C3BD083
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893DA24503B;
	Fri, 14 Nov 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02c1/ki8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PmynlGaS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211731A54F;
	Fri, 14 Nov 2025 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127895; cv=none; b=hylPqV5e7w1e2VjGsCt5o7OVFwfXtj52OlOYFZHhvz4arP1k1H4PE44vKhMxPceiZ9xSpF8gTsoV8ugXDWTXlMs8cI/zqXKnLYQkhK99NNZ10RCtLaQ2+vNVsw7agIPel44fdBfl6U9kP4kYkBPeqWdXN+FCWvnMIrQK5XBngYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127895; c=relaxed/simple;
	bh=fw07xKGbfROzNSO6s4gOHewuveJcVO+rtt2j3lDFjQw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fSrYXQQb1BABKzY5Je0XCJR1gV/leFTHHpRqCJtQTSw/F1oXMceEWBfc/uWmRJbmD1S7dgm8NRw3kyDExIHWIubWAIaMLkU4pPRPBD/rfazSkncJxKTq/I+XoDphiepzLG9h/8zJm2RCjlBtc818atLvquf15WKTw1GylkbtE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02c1/ki8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PmynlGaS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 13:44:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763127891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUOJI4sf28PflsXAfuTYABk7rrcCNjQVFL1txGwiJWQ=;
	b=02c1/ki8MzxSC/c/h5CvsE24SSYlg2iyh5ZAjgAMPhxNnRJeKD4wDmDnpK4vS3XLUegtyB
	fsKwrhiP3gA41yCMpbx9hUupuYsF7z4EGKRDWJLJHVb3zcFcyz0iHl959YZVNmEIiydK7N
	9CzBlLCiVL49gY9cfAMZCFnEfVfo8pC6R/qmEYEh1inOgFmjpEmev99Of5NqVd5OlGrg+l
	7Z9gqD7uciXLgDkodl4I0e6fjHTDqydOtj5VawsSp+Fg/rA4cXLUybDWVHo9nGqmRXZrlr
	+rIlzsO5dnya4PBra/UG0sUpWYa2z+ibFiWMYRuisyLEaFx/j9tYFw2Oa1crow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763127891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUOJI4sf28PflsXAfuTYABk7rrcCNjQVFL1txGwiJWQ=;
	b=PmynlGaS/4gjGYSM7KPJTT3Gl0O+A4ZkCdaz3DJuH+cOLcdKy7Uw/u1xMl7f32NUhkKCeP
	dnz6EHi6QJOTPJAw==
From: "tip-bot2 for Carlos Llamas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] selftests/futex: Skip tests if shmget unsupported
Cc: Carlos Llamas <cmllamas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251016162009.3270784-1-cmllamas@google.com>
References: <20251016162009.3270784-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312789084.498.16255473185862158941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     275498b88104b36a0f7f913da53dc81c1daed277
Gitweb:        https://git.kernel.org/tip/275498b88104b36a0f7f913da53dc81c1da=
ed277
Author:        Carlos Llamas <cmllamas@google.com>
AuthorDate:    Thu, 16 Oct 2025 16:19:41=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 14:39:36 +01:00

selftests/futex: Skip tests if shmget unsupported

On systems where the shmget() syscall is not supported, tests like
anon_page and shared_waitv will fail. Skip these tests in such cases to
allow the rest of the test suite to run.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251016162009.3270784-1-cmllamas@google.com
---
 tools/testing/selftests/futex/functional/futex_wait.c  | 2 ++
 tools/testing/selftests/futex/functional/futex_waitv.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/te=
sting/selftests/futex/functional/futex_wait.c
index 4cd87f2..1eb1633 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -71,6 +71,8 @@ TEST(anon_page)
 	/* Testing an anon page shared memory */
 	shm_id =3D shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 	if (shm_id < 0) {
+		if (errno =3D=3D ENOSYS)
+			ksft_exit_skip("shmget syscall not supported\n");
 		perror("shmget");
 		exit(1);
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/t=
esting/selftests/futex/functional/futex_waitv.c
index c684b10..3bc4e5d 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -86,6 +86,8 @@ TEST(shared_waitv)
 		int shm_id =3D shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
=20
 		if (shm_id < 0) {
+			if (errno =3D=3D ENOSYS)
+				ksft_exit_skip("shmget syscall not supported\n");
 			perror("shmget");
 			exit(1);
 		}

