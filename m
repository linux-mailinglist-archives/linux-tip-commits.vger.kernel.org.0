Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4254278B0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbhJIKJH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49378 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbhJIKJD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:03 -0400
Date:   Sat, 09 Oct 2021 10:07:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nz8RXvwSoWFIc6EM8lJxz5s7vyiLKaqk96xlA8iKPiM=;
        b=TTGSYikVSaZkGTMg//7TRPWiFY627VwqIS8gn1k7PtCbMDse/oCIpunyeH39AZmxadgRtL
        F+tNYrLJa82bIIxVSEYeEFs/D659f3UtNuQ3EjAm4dC6p6oTpfoC13O9RzpQbzzH3/pZKF
        2utQkAKvLqFEUEkYKOIR4uv1rAshSKdacHQdJuQZhZIgeiH13h7nmrhbe9cEN4r15lF+6P
        dSPN2Pxrcrr//nICdhFZ2F4v08fldejqm9YzN3MSa4IZAwG8/Jp/NC4NrBAeJEmNtlquTh
        VR4v1riNvCwUnI8ec5EqsjdbsSNu9/TRdP4H8f0DZ/w5oCNa1Kgu+vxd+27GKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nz8RXvwSoWFIc6EM8lJxz5s7vyiLKaqk96xlA8iKPiM=;
        b=2QgCiA5RimZ6+96NPWqCHfst4nIWVLUXCPpz7Z+6mJZXM9NOR6YUvAPQkbIlJAKlCXuW6Z
        RgGoAfa2BOrkOtCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Simplify double_lock_hb()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-16-andrealmeid@collabora.com>
References: <20210923171111.300673-16-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377402559.25758.4094406809962751599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bff7c57c2f50dca7b5e320f499e0898c3fb8a9ff
Gitweb:        https://git.kernel.org/tip/bff7c57c2f50dca7b5e320f499e0898c3fb=
8a9ff
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:11:04 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:11 +02:00

futex: Simplify double_lock_hb()

We need to make sure that all requeue operations take the hash bucket
locks in the same order to avoid deadlock. Simplify the current
double_lock_hb implementation by making sure hb1 is always the
"smallest" bucket to avoid extra checks.

[Andr=C3=A9: Add commit description]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-16-andrealmeid@collabor=
a.com
---
 kernel/futex/futex.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index fe847f5..465f7bd 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -239,14 +239,12 @@ extern int fixup_pi_owner(u32 __user *uaddr, struct fut=
ex_q *q, int locked);
 static inline void
 double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
-	if (hb1 <=3D hb2) {
-		spin_lock(&hb1->lock);
-		if (hb1 < hb2)
-			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
-	} else { /* hb1 > hb2 */
-		spin_lock(&hb2->lock);
-		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
-	}
+	if (hb1 > hb2)
+		swap(hb1, hb2);
+
+	spin_lock(&hb1->lock);
+	if (hb1 !=3D hb2)
+		spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
 }
=20
 static inline void
