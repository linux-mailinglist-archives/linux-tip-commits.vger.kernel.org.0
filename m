Return-Path: <linux-tip-commits+bounces-3127-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA539FC163
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA73165969
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACA212FAF;
	Tue, 24 Dec 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOmC22sV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUVSWKMM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F10212B1A;
	Tue, 24 Dec 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066425; cv=none; b=WSP9z4ZqFOirT0zuQa+kBjc15Axm+GBPEq7lb4MGnBpymmzM0V/w7m6zRzHUXYKvuanQn8wCRxXuiKbupYvFPEjnr+3RSSTD2azTUWHaWbBg2RvxkAYw9SXpwiBpIOsZAsiWibtDU+ooar4ytuGfYifu7PGZofwQD5QJUGQZ3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066425; c=relaxed/simple;
	bh=Q+dk65uylFj7DgKMiLu/ucT7E85qoE6nRdA9QNZtJo4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rNHwpZj4UqU9I4z7Ypo5X2U0FNO91JvB7ZZCCXb4mQ0V2zAhap7ybYo9mpuUyReskES7yVnZgcJ53NdpqLhi6HErK/bAuirRAY1/jrBM0c0m+sNTu/jQ3uWV+U/MGLkh+zJ5N6C+vqWSfo2YBxf8TbhvStT205PIw/7hlCa2JgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOmC22sV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUVSWKMM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNFfDuWGyCDxpFsRKIfPUBZXLQTXJ7pYOdWNJIk+KRk=;
	b=yOmC22sVFFsfvD9G6zfINhCL3HnQus3KGjJsDIyPRMCaWHDH58gUnB7P+DYgvphPadsHBC
	ZcW9TRrk1oxjUylT5R94NeG/hwWB1ymHXgn6XV3bwxc/kaGal1yUees+VFWetZlkMIe8b2
	xrZMHAVZ0eMCHyXxxBMZ4uyVyVbAQPea7fKxQSYPUwcyLcA0NDU+xSFl8rWOLt5JQ86z9i
	9UTWQxBILN7/24xjcc4sHwsCMyV2X+5foJQ3DRXWy2bHA6z9fcHG0eNEurP16teXrdlZt3
	/1+NRm0NZArrnHeKyQVxc27fl3QgvHk0GUXRf+nh+UkeVX6WjEFouhWCUmU8eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNFfDuWGyCDxpFsRKIfPUBZXLQTXJ7pYOdWNJIk+KRk=;
	b=OUVSWKMMpUE/IIfZslo0mhu/7piAzK7ChY2j6xZfc73AjyC4jNmDW4Ye3tpSDEi/xJZ9td
	zcOU1hWJTscxpBBQ==
From: "tip-bot2 for Lyude Paul" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Make Guard::new() public
Cc: Lyude Paul <lyude@redhat.com>, Filipe Xavier <felipe_life@live.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241119231146.2298971-3-lyude@redhat.com>
References: <20241119231146.2298971-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642158.399.6811616014061227676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     daa03fe50ec376aeadd63a264c471c56af194e83
Gitweb:        https://git.kernel.org/tip/daa03fe50ec376aeadd63a264c471c56af194e83
Author:        Lyude Paul <lyude@redhat.com>
AuthorDate:    Tue, 19 Nov 2024 18:11:04 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 19 Dec 2024 14:04:42 -08:00

rust: sync: Make Guard::new() public

Since we added a `Lock::from_raw()` function previously, it makes sense
to also introduce an interface for creating a `Guard` from a reference
to a `Lock` for instances where we've derived the `Lock` from a raw
pointer and know that the lock is already acquired, there are such
usages in KMS API.

[Boqun: Add backquotes to type names, reformat the commit log, reword a
 bit on the usage of KMS API]

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Filipe Xavier <felipe_life@live.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241119231146.2298971-3-lyude@redhat.com
---
 rust/kernel/sync/lock.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 57dc2e9..72dbf3f 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -234,7 +234,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// # Safety
     ///
     /// The caller must ensure that it owns the lock.
-    pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
+    pub unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         Self {
             lock,
             state,

