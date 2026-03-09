Return-Path: <linux-tip-commits+bounces-8395-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNYzO8okr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8395-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9112405C5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B19BA301A43B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB3425CD6;
	Mon,  9 Mar 2026 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3v8YnFbq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lr7fuIER"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7614421EE3;
	Mon,  9 Mar 2026 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085712; cv=none; b=KYDsln+RB6IWSJGZZnA8atwXd3hKjNVplbotpXSyEshZ66G00lsqAJVWU6hfGw5lxf27fbKj6wiasX3viU/vSt0bhE9QmCTT9r+Sll+N0kwl/AE1/TbBUM3dHcPgh1N/DpGwPIB2toP97fVa7GAWYhxf0ua72g3jEEh1bqQDtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085712; c=relaxed/simple;
	bh=OYA3oXGT6uR5aQYUarvAcTEZTjD0cGV5/2kYEkTRFyw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ekovXv2oztVN3Vob0GTuWuQWyK+NYnU16UNohFaKEOIELsI6OYWYUlwX7rX36/2BIH+QaVQcw0UKbdtk36T1c70whoOcmxCzLlWcmi7lfPoZKbq+fg0CfkuNKj/aqhYPFqFAAAnC91jU93fulKGJq5XvodwAFP+2qaPxOscdEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3v8YnFbq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lr7fuIER; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEyJ0fYrgRjQqgNu088BjT2G5xft8Ube+FyUwO7f7CA=;
	b=3v8YnFbqzxwq6hm7SSibM+cGv3TZDdHrRiNeiEkactK7rsVwVIFxW4uysb5r/XwolMnots
	7oL2nmJPW1xIfi828wPk71a/I0epcX0RkZ+5aZnEBMzjwQttbGxBFcF9nhsjlDyY96IcoW
	i58pBfR0VHnWrtQlFNd6yuDybBwX7iwgo1chTErca6lQRs821C5M7CGC0f19e/1LKunJqd
	yH3jp+XicLACvVSwZZdBBWJ7M4nkeFyc1PXSdZ1RU7ka5p9Q+u29iH4u2T5qCHV17QNnF6
	/LmnZmv26Ei6KCs73+O8ltLLksz4k3hsvoIZPJC/15TpthJav5YVDGin/SZiMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEyJ0fYrgRjQqgNu088BjT2G5xft8Ube+FyUwO7f7CA=;
	b=lr7fuIERaf4fuYQlKHJxCweHxcBR+K/zkwXpDUMiFjUEOA9qz/7qbZMhFrtCyVwHppcHh/
	OWgvequhQ+sulPBg==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Clarify the need of
 CONFIG_ARCH_SUPPORTS_ATOMIC_RMW
Cc: Dirk Behme <dirk.behme@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Gary Guo <gary@garyguo.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-7-boqun@kernel.org>
References: <20260303201701.12204-7-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570798.1647592.7115196531861061237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6A9112405C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8395-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,infradead.org,garyguo.net,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,infradead.org:email,msgid.link:url,garyguo.net:email,linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     553c02fb588d4310193eba80f75b43b20befd1d2
Gitweb:        https://git.kernel.org/tip/553c02fb588d4310193eba80f75b43b20be=
fd1d2
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:54 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:49 +01:00

rust: sync: atomic: Clarify the need of CONFIG_ARCH_SUPPORTS_ATOMIC_RMW

Currently, since all the architectures that support Rust all have
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW selected, the helpers of atomic
load/store on i8 and i16 relies on CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy.
It's generally fine since most of architectures support that.

The plan for CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dn architectures is adding
their (probably lock-based) atomic load/store for i8 and i16 as their
atomic_{read,set}() and atomic64_{read,set}() counterpart when they
plans to support Rust.

Hence use a statis_assert!() to check this and remind the future us the
need of the helpers. This is more clear than the #[cfg] on impl blocks
of i8 and i16.

Suggested-by: Dirk Behme <dirk.behme@gmail.com>
Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260120140503.62804-2-boqun.feng@gmail.com
Link: https://patch.msgid.link/20260303201701.12204-7-boqun@kernel.org
---
 rust/kernel/sync/atomic/internal.rs | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/in=
ternal.rs
index 0dac58b..ef516bc 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -37,16 +37,23 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Seal=
ed {
     type Delta;
 }
=20
-// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the at=
omicity is only
-// guaranteed against read-modify-write operations if the architecture suppo=
rts native atomic RmW.
-#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
+// The current helpers of load/store of atomic `i8` and `i16` use `{WRITE,RE=
AD}_ONCE()` hence the
+// atomicity is only guaranteed against read-modify-write operations if the =
architecture supports
+// native atomic RmW.
+//
+// In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dn architecture pla=
ns to support Rust, the
+// load/store helpers that guarantee atomicity against RmW operations (usual=
ly via a lock) need to
+// be added.
+crate::static_assert!(
+    cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
+    "The current implementation of atomic i8/i16/ptr relies on the architecu=
re being \
+    ARCH_SUPPORTS_ATOMIC_RMW"
+);
+
 impl AtomicImpl for i8 {
     type Delta =3D Self;
 }
=20
-// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the at=
omicity is only
-// guaranteed against read-modify-write operations if the architecture suppo=
rts native atomic RmW.
-#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
 impl AtomicImpl for i16 {
     type Delta =3D Self;
 }

