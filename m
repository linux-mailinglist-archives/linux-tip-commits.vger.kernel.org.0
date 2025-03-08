Return-Path: <linux-tip-commits+bounces-4087-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCFFA57AB1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8BF16D539
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501251CEAC8;
	Sat,  8 Mar 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6XPw9Xz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRXPZMuu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD01E3DD7;
	Sat,  8 Mar 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441508; cv=none; b=V3ha1LkTI4pUD7S3UOK4zBRuxqyfX/uB2PDmDd/TtKxRrv+GNHYgLaGjTbif8r6vCkeNmtQ70NwX523AJS2cJHejZyRUHI1kSEekZ1EBtY0VbP9fTqxfoDXkPXEbP9Cvm4HbzBgRuzUkWQKbEMSbKWClXyu1o0MPJaGfM7XDqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441508; c=relaxed/simple;
	bh=MsozlJIBLCDs2MpwTmGDiT2hxD4XhwFvzbqOD83oe+8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TkCaWtre7lkZeqBr6Qk7b5OM8ok3wbRkHS+BqmxZc0T3GtyLbeF+UwZ9zYMHm5/k3puV7KbJSh9Lkhbz1AhFLXo8IJNjxQm4m7CUgMLkG6edi63SzOCQKH8et85K+iC8JTg0KmdgZZIW77T/DRkUTDEyaLG1SB0VqDVcfMLTcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6XPw9Xz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SRXPZMuu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qf1jVFzyCxyGhnlEgHcX46xwhXr3L0NMqrq3FVQUWHg=;
	b=U6XPw9XzoQxnjuExTtZDl68N8hXCOW9/GJ3ONDN9ytN01/uagaynWP9ttTwMXFOVpy2eKk
	zVVGu6F75CZjaNPAlNYkhGpSLsTSY7HCRi7FQH75f7SJMSzMAr8cgg3A+6ySTUieC16mSP
	phWJkFuDxGW2VLkqYVJXZWns2B9I47nzeKE1IO2s2g3hCJ3A4nBKFdhg1fWiBKN6JX9Dz2
	BBd9SYa5fMmh+gg0m9Puh14MbLb6j9F7nJU1qfoy7OkK+1+eyOh4BFLyK8dgGywhQjmJw/
	bGb71n+fp2RN4kztnUHabjBvLnAeBQlLQPlt9Qc8QQSIiR9pR4aBjRrmyKU6zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qf1jVFzyCxyGhnlEgHcX46xwhXr3L0NMqrq3FVQUWHg=;
	b=SRXPZMuufyn54QOqh833yBiAv5pgpadQEHwVK1KBeMA8avK9fzWAa5dL9n4oKGync6gof/
	7s/u/EdMDLYlNIDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/datapage: Define vdso_clock to prepare for
 multiple PTP clocks
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-4-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-4-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150426.14745.9552475560705652616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     a05f14de04e989f0bc32cea128243090e5e5d54b
Gitweb:        https://git.kernel.org/tip/a05f14de04e989f0bc32cea128243090e5e=
5d54b
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:40 +01:00

vdso/datapage: Define vdso_clock to prepare for multiple PTP clocks

Multiple PTP clocks, which are independent of timekeeping, are required for
systems, which utilize PTP for synchronizing e.g. automation systems
independent of clock TAI.

PTP clocks are slow to access, but applications require fast access to the
relevant time similar to the regular timekeeping relevant clocks.

To prepare for that the VDSO data representation must be reworked. For
transition to the new structure of the vdso, add a define which maps
vdso_clock to vdso_data. This will be removed when all users are updated
step by step.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-4-c1b5c69a166f@linut=
ronix.de

---
 include/vdso/datapage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index dfd98f9..1df22e8 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -129,6 +129,8 @@ struct vdso_time_data {
 	struct arch_vdso_time_data arch_data;
 } ____cacheline_aligned;
=20
+#define vdso_clock vdso_time_data
+
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds

