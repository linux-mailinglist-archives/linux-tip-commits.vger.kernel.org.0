Return-Path: <linux-tip-commits+bounces-7923-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0EBD183BE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6F48304BBC2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B838E12A;
	Tue, 13 Jan 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mKZXl1Lq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YjEFqbPh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B03803EC;
	Tue, 13 Jan 2026 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301402; cv=none; b=S6h3Rlv1F61icDVOoI3rfA48WgxWIH5pu/XWXMsoQDNtzWoSn0ly2y5IQH8POKuBfSTR6eh2lQ8x1UUVPZWc+ozJ/GFDrfT2sbR52sI95IoTAM+8jXa+zdwq3NdNfs1z8R17EoJMCdflMqWC5nUMslflHRORqnmBSMJDIBa3y08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301402; c=relaxed/simple;
	bh=TUJenf+9h81LkWz9/Pe2oy9vT6DIz/PduwTkZMAkcps=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r8o5H/uyw6ZoMoJ3M8HA7xIEEuTUprStNHQh2HiLZhnoSqo/8qKxr1fzjKYBYYj18m4oC1UlWlWMBS9VAGsKESPqKq0M30vjFXmW4Ok1ZsMPOmmWL3W8tV8X2tA35F5icV8werq1FLIxnkr/cGvx0oQGUUQHejwE/PFsmnGwUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mKZXl1Lq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YjEFqbPh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4A71F/a4JzGxJyqDsMdQ+aiz31/5uH4sCG+6Bfn1WY=;
	b=mKZXl1LqL17/btCZP430q+DX1xRVg4nMCxQjjW8znbvycPlajfvR6weAwoXLMLLfn7JDcH
	cYxcPfnL5dSQ/Lx3/9k0byppVZvVncRZy+W1PtLtc0HNDQxeroyXzm2dW1lj9oD+qBsVfo
	1ZK3Ke2D8Uahx7tzawhsMkA9yJ9g9BJz3XY55U7N5zALXc2FQn/1HPRQJzni2bxMQt/q97
	rTU/KlxYC/gQwro49XiSM2z5uLw2j9cvbHmHG8wIbAGicQYCkmY1DU/bOAw5iIvePLAu+U
	yWWh/oergOJwd90Ee/Yofyk24iVDEc9Qc4gFlXkaomqf3CswhruOD8eK0/I+Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4A71F/a4JzGxJyqDsMdQ+aiz31/5uH4sCG+6Bfn1WY=;
	b=YjEFqbPhsqcaP8Cl2Hny4S2+E4Zr0w1AkG4UKD0XV8SitMRuVpIHVmIbXtbikTvLnyq8f1
	EBtZSAY6CVrToyAg==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add atomic bool tests
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260101034922.2020334-3-fujita.tomonori@gmail.com>
References: <20260101034922.2020334-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830139101.510.8913819849324905085.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4bac28727a2b3f33e6375aeafdf31df67deff5d0
Gitweb:        https://git.kernel.org/tip/4bac28727a2b3f33e6375aeafdf31df67de=
ff5d0
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Thu, 01 Jan 2026 12:49:22 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: sync: atomic: Add atomic bool tests

Add tests for Atomic<bool> operations.

Atomic<bool> does not fit into the existing u8/16/32/64 tests so
introduce a dedicated test for it.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260101034922.2020334-3-fujita.tomonori@gmail=
.com
---
 rust/kernel/sync/atomic/predefine.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index 3fc9917..42067c6 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -199,4 +199,20 @@ mod tests {
             assert_eq!(v + 25, x.load(Relaxed));
         });
     }
+
+    #[test]
+    fn atomic_bool_tests() {
+        let x =3D Atomic::new(false);
+
+        assert_eq!(false, x.load(Relaxed));
+        x.store(true, Relaxed);
+        assert_eq!(true, x.load(Relaxed));
+
+        assert_eq!(true, x.xchg(false, Relaxed));
+        assert_eq!(false, x.load(Relaxed));
+
+        assert_eq!(Err(false), x.cmpxchg(true, true, Relaxed));
+        assert_eq!(false, x.load(Relaxed));
+        assert_eq!(Ok(false), x.cmpxchg(false, true, Full));
+    }
 }

