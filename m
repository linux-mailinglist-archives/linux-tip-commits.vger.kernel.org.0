Return-Path: <linux-tip-commits+bounces-8124-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI+SHNzJeWkezgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8124-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:33:32 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FA19E3EC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ADE63013A7B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 08:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD92F39B8;
	Wed, 28 Jan 2026 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ObyGaoV7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zsqUc5HI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E92D249E;
	Wed, 28 Jan 2026 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589207; cv=none; b=VQ7YLOq7+Ie0aAkTruiqVmaybqZvRgfY1DEkyK/9COlsa9cLPGCG8q+3w4438+qb9smPePP9iVZ32WtfON1d+Yo3fc5aKNOb+8otRKabG4HryzEdA4mFqQyzB8le6m9FSIBksbPSKLs7dhyoDJX7JjBKNuFC1eksY1Ot65qxTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589207; c=relaxed/simple;
	bh=phyHKD4VYthBJkEU2tGhSnsoa7TEOGn7ndrbIjJigzY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WwhuBqA2VLpG/b9XJaBDSzKXo16MWeBpxEJYaofE6x0J/gBQKuQuQEQLkKkITlIy6uvF3ACz4AxYlUxJfbS6JxhU4YfhqsQCfAY+3EV/5oZsHLfAOuEt6NlDp5r4/x6ojZcLgxa0/FqhmkR3w9Y6ArFdlLeZko42lvskVSOtam0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ObyGaoV7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zsqUc5HI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 08:33:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769589204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVyPlM4tlbcZCiYOfbYm6yFsNWynNu+HUpowF3qdufM=;
	b=ObyGaoV745oN7ltHqi4Xu9FfTqHSzD7dy+gUyn9Sxyk2+4GTm2vgW419N3BFKileh39umU
	ROSbB1Z6YxpoQV55GhV763/BKlWBdi2VZ1LTpNpE06NIQVjBMhkD0pAbtZvTGxOGwXhLO+
	wYLrZX0KvCzewe0jJm2wlh2P+bmi4tYQ7T4wzd1w3inulNmxdEAIo0LQ9605g1/2SzjGYf
	mu1ZVqqDY3RYrWJGfxDpMPWLw3SyL5relQxfo1zYeEFIgZ3rejlkr9l+VCJ1894gsbyx/e
	XUTf13nSZeRtF77LJMSeHS1qybKznLJM6uEvXwtU7iO+eB/0dwn8HkCynSYk0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769589204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVyPlM4tlbcZCiYOfbYm6yFsNWynNu+HUpowF3qdufM=;
	b=zsqUc5HI1uJ6xeTww9fA1oskZzgc+LhPzBnMv1jkUv0WJmRHcqCJljwntiM2+tYvEMfEuF
	RDcCe69QB2pXQ5CQ==
From: "tip-bot2 for Tamir Duberstein" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: Replace `kernel::c_str!` with C-Strings
Cc: Tamir Duberstein <tamird@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Gary Guo <gary@garyguo.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260123054624.8226-2-boqun.feng@gmail.com>
References: <20260123054624.8226-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176958920344.510.9567843514888583363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8124-lists,linux-tip-commits=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,infradead.org,garyguo.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	DKIM_TRACE(0.00)[linutronix.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 08FA19E3EC
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e6de07249ef381b674f0d65adf9defcdab76b768
Gitweb:        https://git.kernel.org/tip/e6de07249ef381b674f0d65adf9defcdab7=
6b768
Author:        Tamir Duberstein <tamird@kernel.org>
AuthorDate:    Thu, 22 Jan 2026 21:46:24 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 09:25:44 +01:00

rust: sync: Replace `kernel::c_str!` with C-Strings

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260120-cstr-sync-again-v1-1-2a775a2a36fd@ker=
nel.org
Link: https://patch.msgid.link/20260123054624.8226-2-boqun.feng@gmail.com
---
 rust/kernel/sync.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index b10e576..993dbf2 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -126,13 +126,12 @@ impl PinnedDrop for LockClassKey {
 /// # Examples
 ///
 /// ```
-/// use kernel::c_str;
 /// use kernel::sync::{static_lock_class, Arc, SpinLock};
 ///
 /// fn new_locked_int() -> Result<Arc<SpinLock<u32>>> {
 ///     Arc::pin_init(SpinLock::new(
 ///         42,
-///         c_str!("new_locked_int"),
+///         c"new_locked_int",
 ///         static_lock_class!(),
 ///     ), GFP_KERNEL)
 /// }

