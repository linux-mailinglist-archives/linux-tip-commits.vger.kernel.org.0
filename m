Return-Path: <linux-tip-commits+bounces-7908-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564DD1830A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 944793004840
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CED35C1BA;
	Tue, 13 Jan 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PXBkakah";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1AAXisRd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7D28488F;
	Tue, 13 Jan 2026 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301378; cv=none; b=io6obLXCCgqVXrj5MEdMgqib9KljOTXSqRkDgeoqjlbs2Dibe6n3oOSMsuyhHsO21pm819UuSEg92zdNBHS3agbF6mz75pqdNBU9JbWGru1u98GcX6MsOf7g1f7GPMhtX7RWrH1PhO12PjbaFE8s3Aozvbfisj13stZHy7DlXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301378; c=relaxed/simple;
	bh=JmyvPPNM902C5Yd1uSXNGhHwuSKdlulwUHK3agBwigc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KodLUoXgWwsiJOaqaqpsflr3bCGYQEZxWi5GZJjCWUkzEixcDq8G3B9Bc5ZrucHLdCLIGGjaL/sTWfZE+6jE7W+is1duPx3GntFm1yJVkoEat7a2AZDv20iy/Fe8Uw8TOtAQrCiHjT0jCveF43LaSQMKkeC2QtrrErBibTNjQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PXBkakah; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1AAXisRd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUOEAu7+9Ome6nomulI6RRBUEznU+pd/t2i2lYIjqhA=;
	b=PXBkakahsTnGn6DXqrzkCz+i2kCH98hNHmPISe8q4s1uxrVnDiZ2scopffcSkbFOwAuYbv
	PRD62o2z4tsMOFdJOSOkcQlxbIKTh/F0KGK7WAGo+zswVcicdjsBC13/iRuejYYBXxHBld
	8YKSRR9mTGifhcZJi+goIUPiVsh5aXrphCS3UYDM5VgBGOo6mEZMZUqDq0FyxJ4D+LLM0O
	LAmGpLPwXQ4hy/mrIl1EFokXwQ9cO7PvmJcWY6fUEFyABT9b2UthHdxjfpMUjZx5dds3OM
	L8WuQ7Z3a+MP/Qu0IgLTnwU0251TzyEJREXHxrc9DtGwYeWNTFrrE8J8VvwxRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUOEAu7+9Ome6nomulI6RRBUEznU+pd/t2i2lYIjqhA=;
	b=1AAXisRdjvFghGQmN4aJ5/PwySTS51cE0TICKvnqiFY6NXqgVwIp2yipL57vZvdYxOuYJL
	oxWt6AvuDwLgFGDA==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: helpers: Move #define __rust_helper out of atomic.c
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260107-move-rust_helper-define-v1-1-4109d58ef275@google.com>
References: <20260107-move-rust_helper-define-v1-1-4109d58ef275@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830137479.510.320717391644609032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     abf2111d8d900c834993d443f59b836291b8d0fc
Gitweb:        https://git.kernel.org/tip/abf2111d8d900c834993d443f59b836291b=
8d0fc
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Wed, 07 Jan 2026 14:14:13=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:42 +08:00

rust: helpers: Move #define __rust_helper out of atomic.c

In order to support inline helpers [1], we need to have __rust_helper
defined for all helper files. Current we are lucky that atomic.c is the
first file in helpers.c, but this is fragile. Thus, move it to
helpers.c.

[boqun: Reword the commit message and apply file hash changes]

Link: https://lore.kernel.org/r/20260105-define-rust-helper-v2-0-51da5f454a67=
@google.com [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260107-move-rust_helper-define-v1-1-4109d58e=
f275@google.com
---
 rust/helpers/atomic.c                     | 7 +------
 rust/helpers/helpers.c                    | 2 ++
 scripts/atomic/gen-rust-atomic-helpers.sh | 5 -----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
index cf06b7e..4b24ece 100644
--- a/rust/helpers/atomic.c
+++ b/rust/helpers/atomic.c
@@ -11,11 +11,6 @@
=20
 #include <linux/atomic.h>
=20
-// TODO: Remove this after INLINE_HELPERS support is added.
-#ifndef __rust_helper
-#define __rust_helper
-#endif
-
 __rust_helper int
 rust_helper_atomic_read(const atomic_t *v)
 {
@@ -1037,4 +1032,4 @@ rust_helper_atomic64_dec_if_positive(atomic64_t *v)
 }
=20
 #endif /* _RUST_ATOMIC_API_H */
-// 615a0e0c98b5973a47fe4fa65e92935051ca00ed
+// e4edb6174dd42a265284958f00a7cea7ddb464b1
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 15d7557..a3c42e5 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,8 @@
  * Sorted alphabetically.
  */
=20
+#define __rust_helper
+
 #include "atomic.c"
 #include "atomic_ext.c"
 #include "auxiliary.c"
diff --git a/scripts/atomic/gen-rust-atomic-helpers.sh b/scripts/atomic/gen-r=
ust-atomic-helpers.sh
index 45b1e10..a373215 100755
--- a/scripts/atomic/gen-rust-atomic-helpers.sh
+++ b/scripts/atomic/gen-rust-atomic-helpers.sh
@@ -47,11 +47,6 @@ cat << EOF
=20
 #include <linux/atomic.h>
=20
-// TODO: Remove this after INLINE_HELPERS support is added.
-#ifndef __rust_helper
-#define __rust_helper
-#endif
-
 EOF
=20
 grep '^[a-z]' "$1" | while read name meta args; do

