Return-Path: <linux-tip-commits+bounces-8389-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAfAJigkr2n6OQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8389-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:48:56 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB82404F8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3AED301C979
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3EF41B356;
	Mon,  9 Mar 2026 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qtp3zdP7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zayRt4r1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F1411613;
	Mon,  9 Mar 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085707; cv=none; b=JKbk0fw2+U5Du/SV+9By73tobDsEOlhFXKHsHDGYySAV69drdYs9NuLLC43I0zn6GVgptbNbmJ5gzMIBtauOojLrQayQ8SlQvmeKASLXiYKAjfbrmHi5go2n/gjdqyeiDQFOaVttUm8rS/VbxHiszcI9yRcP20XWZ+4vVOeSU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085707; c=relaxed/simple;
	bh=X/iJt6YiGC2SecF/oiN9Q7cKvEUA4rS+X98gmTsqhZo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fmh+3QCHj/tK5q96Tq2ebHNqDiY3oMqsNK3xRUcg+VVVsSHxlI9EJYqfkBlnHkvJ76MkNR+NvCqm5BAK4o5IKyu2nMbhEZj37gocPBjcIg/u2OwAQFWb+hCpRr96dqbYm3vZcXn+fZVE6k+C5IT2jVJrXrS9DpaujOqG9Y+y+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qtp3zdP7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zayRt4r1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Egx0cjSRpFXvKULJK9tO/gPCY/I1ykOIMgY0lh9Mlc=;
	b=qtp3zdP7FY7MbASO1seXFrj6QxnaHz0DNTDhPvWrueQGoXR8Qm8VcflwXhe+JTOQU/YEm8
	o+NaosMWMQCf7vi3u6Qi+y/XIuzvdCN+e0IlIVBIIixqR+j+xzu/D3nY6nxJH1X8sz2o0Y
	CxZN5y4AU+TAVlEaqkEMLJZT1l934ylDdDzwRq78+jG7gR+iclj2WdrMUd/7iJrN2zhrVz
	YH/e0cSdW4szqy3zK+WUCeEsP+OoI0s2zrXgEmO2ho98RVit+deQ9d6a4DYjj1QCDPzL3b
	Ytfda+NJ1fJB8cdTVRqqSLdj6mBGZ1CXU932bxaR6Uh6Y2MJwIf5/cvaIF6C+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Egx0cjSRpFXvKULJK9tO/gPCY/I1ykOIMgY0lh9Mlc=;
	b=zayRt4r1qmqNH0RX0X98Ku00CAFjJ56+opCZf0KyHugphQ+hSWoUjfVi7lOVGmQn7TewHv
	KQ5PueViqrRTzTCw==
From: "tip-bot2 for Andreas Hindborg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Update documentation for
 `fetch_add()`
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-13-boqun@kernel.org>
References: <20260303201701.12204-13-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570144.1647592.10721623995267810883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 52AB82404F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8389-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,infradead.org:email,vger.kernel.org:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0b864375d93d1509821def9c4b15f845d314a5d2
Gitweb:        https://git.kernel.org/tip/0b864375d93d1509821def9c4b15f845d31=
4a5d2
Author:        Andreas Hindborg <a.hindborg@kernel.org>
AuthorDate:    Tue, 03 Mar 2026 12:17:00 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:51 +01:00

rust: sync: atomic: Update documentation for `fetch_add()`

The documentation for `fetch_add()` does not indicate that the original
value is returned by `fetch_add()`. Update the documentation so this is
clear.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260220-atomic-sub-v3-2-e63cbed1d2aa@kernel.o=
rg
Link: https://patch.msgid.link/20260303201701.12204-13-boqun@kernel.org
---
 rust/kernel/sync/atomic.rs | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 545a8d3..9cd009d 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -545,16 +545,14 @@ where
     /// use kernel::sync::atomic::{Atomic, Acquire, Full, Relaxed};
     ///
     /// let x =3D Atomic::new(42);
-    ///
     /// assert_eq!(42, x.load(Relaxed));
-    ///
-    /// assert_eq!(54, { x.fetch_add(12, Acquire); x.load(Relaxed) });
+    /// assert_eq!(42, x.fetch_add(12, Acquire));
+    /// assert_eq!(54, x.load(Relaxed));
     ///
     /// let x =3D Atomic::new(42);
-    ///
     /// assert_eq!(42, x.load(Relaxed));
-    ///
-    /// assert_eq!(54, { x.fetch_add(12, Full); x.load(Relaxed) } );
+    /// assert_eq!(42, x.fetch_add(12, Full));
+    /// assert_eq!(54, x.load(Relaxed));
     /// ```
     #[inline(always)]
     pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Or=
dering) -> T

