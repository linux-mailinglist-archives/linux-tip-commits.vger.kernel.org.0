Return-Path: <linux-tip-commits+bounces-6923-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C4BE2997
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 727E65021A2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A65A33CEA9;
	Thu, 16 Oct 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ao8aSl+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RSq7Xarm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61E31A05E;
	Thu, 16 Oct 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608415; cv=none; b=Gu+5l/yEbMtKTHDe5pr5iXGgGKbrsHYTqtQsbrWOz9rXmiTsKAwGVRw+00kvKEOnxs0lF9LetQ7CU0RzX/TLFmjwpNRnDM26PH0s8EQdMwaLjiHZ0+RianTWb1Pl5GmFJPT1xaWq62X2E8rLQhee8YELOhvWhLhA6a3tRuzLX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608415; c=relaxed/simple;
	bh=+xpBx7k07jZ4LQ9hky173wQrzVvZm/knOOq57qahv8U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=buQTVqvK0UwA6tVBKQNU1v46m8psQb2SOGeNQAymY9M0HgcpiSeEL0JUvTGL+G5gmuSoFm89FZbLI0f50vkrdpurdOZhP6770ezA9LX+lWp+jzjELYPz1wQo5sJRoQlI1zq236lfd7wxfHqnmDqQUiTg/YQmaUpOOAt6epJ3Xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ao8aSl+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RSq7Xarm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=TfKGgZHS2RvAB5nIZKi4dbbmygJOQyFwTvs7zXHeocQ=;
	b=2ao8aSl+KANPISN9916TkJJVltQwhX2FyLkrs3VgLXJ3mRYAhSbyj5coVJanWFibGhD2xW
	/XIqjmPnqS5b0j2u1BSsR9rRt0cSbEs1nMeu62v6hQI/L/019nyDOInd/e7QuhyorzC/t0
	Z7QXExhCElhgH88L29nZZjWqG41mb+xQXzXxQI9x6jGaftFfsYs0X5BhR98Vgqf/HbGaMV
	zqwaaxOnGm2aQzZbkzo+uY7nBCY+LM/rfeDXvhoBqolPcNOZqHAjJohlhYbCWozbKTbcNu
	AJk7V3T6/I56Ed3Zj1rEbPoY0876qUM65hN/E/eqOCB5n2sWXRRY3ElA3XEkLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=TfKGgZHS2RvAB5nIZKi4dbbmygJOQyFwTvs7zXHeocQ=;
	b=RSq7XarmzK7BTJJXwWlSczTIWNG5xuf2WfCFVLBM9Xm6U2vEmPZS8MLbdpmXE/IKjIYRC+
	Ad/klqizo9l64GCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] compiler: Tweak __UNIQUE_ID() naming
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060839451.709179.10073158120606095178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     afb026b6d35c79f6f47752147327932827aeac8c
Gitweb:        https://git.kernel.org/tip/afb026b6d35c79f6f47752147327932827a=
eac8c
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:13 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:21 -07:00

compiler: Tweak __UNIQUE_ID() naming

In preparation for the objtool klp diff subcommand, add an underscore
between the name and the counter.  This will make it possible for
objtool to distinguish between the non-unique and unique parts of the
symbol name so it can properly correlate the symbols.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/compiler.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5b45ea7..6a32250 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -163,7 +163,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, =
int val,
 	__asm__ ("" : "=3Dr" (var) : "0" (var))
 #endif
=20
-#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER=
__)
+/* Format: __UNIQUE_ID_<name>_<__COUNTER__> */
+#define __UNIQUE_ID(name)					\
+	__PASTE(__UNIQUE_ID_,					\
+	__PASTE(name,						\
+	__PASTE(_, __COUNTER__)))
=20
 /**
  * data_race - mark an expression as containing intentional data races

