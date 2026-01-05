Return-Path: <linux-tip-commits+bounces-7799-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E915DCF497D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8113D30F0FAB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F323346A1E;
	Mon,  5 Jan 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g6t5QoZa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEcSJx8y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098243469FA;
	Mon,  5 Jan 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628470; cv=none; b=Hz3aFum1xpFecVR6FcGyoABinkBqaTNEVEUcW2jGtJX+AXsrrGeI3N6pf5WhscmkgG1i2k9OvfPJR4q8ARb3M2AqN2NZ2MgfRzldAuaXlrSj+wBWz7jICibKF/s+MhGSD8a+oy/y4PFYb+d8a1dBWlbk3fWjggIu4iZgUrgoHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628470; c=relaxed/simple;
	bh=8LW2Qr+Y92cq/S0CaDC82b9NBUoaGmk4x0npK0paJZs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iXw0pbK3Z7K+M9CdLDG7U4P/+Y3pjxVf6tfVMh3UthIdNq1BY+SR3FJkc62/i3MRlVoCwIekKHSA8FygyR9/vTYutSAu05k9ab8AfMfK5fwa3wR/9l465cVyA/jF0+fp1n+eUl8F471WJWZ9qZ/Kq7gt2OnAkSIg359wfSZQ1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g6t5QoZa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEcSJx8y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WazbetdocTTdpoKXvrl/xUCFjGQ6kJOS4ni3FUuKK/o=;
	b=g6t5QoZabThpIYzXOjHO1GiMVhXN64jIN8kpKrbHnp8KNUCwpuI+al/pLLZJ/tKXCILpFM
	Snc0WX3uGYfbLbbTMyBJHJC+XmsIdJe7E6lPZYUdbBjd4WuPaczW/7X2/tGch+PHDQd/uO
	LezqCGzG0O+vY723OjigYmEWpJz5DyQK6hlIk+4sI2rRexjOLSr5SDTJQKpj4IuVpeZZ+r
	eKFnMMwDXBU7QcrM4+OO2x4AtDpbeazv+1Njf6V6Re/1Qb4e1HCamjTs3McOboVG4EA7CB
	hl8gZcmdeabeg+l6AmZvqcWKzhJe+gs74wizEHA3ozFBIud4BzpuEBErBDU64g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WazbetdocTTdpoKXvrl/xUCFjGQ6kJOS4ni3FUuKK/o=;
	b=MEcSJx8y+6vN+fYgZAYmSRHWKoU2X0fBfKepCqoX3If7CsUnJ0IWmZwiwMo3vmJjVwvUL0
	ELoVsprjsNJjb4AQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] um: Fix incorrect __acquires/__releases annotations
Cc: kernel test robot <lkp@intel.com>, Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-23-elver@google.com>
References: <20251219154418.3592607-23-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846523.510.4433388177316542843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4f109baeea4dc6fa1426ab559159d3bb35e05343
Gitweb:        https://git.kernel.org/tip/4f109baeea4dc6fa1426ab559159d3bb35e=
05343
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:32 +01:00

um: Fix incorrect __acquires/__releases annotations

With Clang's context analysis, the compiler is a bit more strict about
what goes into the __acquires/__releases annotations and can't refer to
non-existent variables.

On an UM build, mm_id.h is transitively included into mm_types.h, and we
can observe the following error (if context analysis is enabled in e.g.
stackdepot.c):

   In file included from lib/stackdepot.c:17:
   In file included from include/linux/debugfs.h:15:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:7:
   In file included from include/linux/list_lru.h:14:
   In file included from include/linux/xarray.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
   In file included from include/linux/mm_types.h:26:
   In file included from arch/um/include/asm/mmu.h:12:
>> arch/um/include/shared/skas/mm_id.h:24:54: error: use of undeclared identi=
fier 'turnstile'
      24 | void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile);
         |                                                      ^~~~~~~~~
   arch/um/include/shared/skas/mm_id.h:25:53: error: use of undeclared identi=
fier 'turnstile'
      25 | void exit_turnstile(struct mm_id *mm_id) __releases(turnstile);
         |                                                     ^~~~~~~~~

One (discarded) option was to use token_context_lock(turnstile) to just
define a token with the already used name, but that would not allow the
compiler to distinguish between different mm_id-dependent instances.

Another constraint is that struct mm_id is only declared and incomplete
in the header, so even if we tried to construct an expression to get to
the mutex instance, this would fail (including more headers transitively
everywhere should also be avoided).

Instead, just declare an mm_id-dependent helper to return the mutex, and
use the mm_id-dependent call expression in the __acquires/__releases
attributes; the compiler will consider the identity of the mutex to be
the call expression. Then using __get_turnstile() in the lock/unlock
wrappers (with context analysis enabled for mmu.c) the compiler will be
able to verify the implementation of the wrappers as-is.

We leave context analysis disabled in arch/um/kernel/skas/ for now. This
change is a preparatory change to allow enabling context analysis in
subsystems that include any of the above headers.

No functional change intended.

Closes: https://lore.kernel.org/oe-kbuild-all/202512171220.vHlvhpCr-lkp@intel=
.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-23-elver@google.com
---
 arch/um/include/shared/skas/mm_id.h |  5 +++--
 arch/um/kernel/skas/mmu.c           | 13 ++++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/ska=
s/mm_id.h
index fb96c0b..18c0621 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -21,8 +21,9 @@ struct mm_id {
 	int syscall_fd_map[STUB_MAX_FDS];
 };
=20
-void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile);
-void exit_turnstile(struct mm_id *mm_id) __releases(turnstile);
+struct mutex *__get_turnstile(struct mm_id *mm_id);
+void enter_turnstile(struct mm_id *mm_id) __acquires(__get_turnstile(mm_id));
+void exit_turnstile(struct mm_id *mm_id) __releases(__get_turnstile(mm_id));
=20
 void notify_mm_kill(int pid);
=20
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 0095778..b501709 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -23,18 +23,21 @@ static_assert(sizeof(struct stub_data) =3D=3D STUB_DATA_P=
AGES * UM_KERN_PAGE_SIZE);
 static spinlock_t mm_list_lock;
 static struct list_head mm_list;
=20
-void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile)
+struct mutex *__get_turnstile(struct mm_id *mm_id)
 {
 	struct mm_context *ctx =3D container_of(mm_id, struct mm_context, id);
=20
-	mutex_lock(&ctx->turnstile);
+	return &ctx->turnstile;
 }
=20
-void exit_turnstile(struct mm_id *mm_id) __releases(turnstile)
+void enter_turnstile(struct mm_id *mm_id)
 {
-	struct mm_context *ctx =3D container_of(mm_id, struct mm_context, id);
+	mutex_lock(__get_turnstile(mm_id));
+}
=20
-	mutex_unlock(&ctx->turnstile);
+void exit_turnstile(struct mm_id *mm_id)
+{
+	mutex_unlock(__get_turnstile(mm_id));
 }
=20
 int init_new_context(struct task_struct *task, struct mm_struct *mm)

