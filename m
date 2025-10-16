Return-Path: <linux-tip-commits+bounces-6921-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F6BE2954
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FFD73552F4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED633CE9C;
	Thu, 16 Oct 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qknzVQzs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g6i4VDXB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E2335BDA;
	Thu, 16 Oct 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608414; cv=none; b=AXMYBhlNLtps6oTiKcD+RXqtiW2KwdigO2/W865sTQWWaQY4G81K7gtmOh/J9/9T+kes3tdyqEj0Sr4zEnDMCaW15WOeLk7wNFbwfpnRmGmH50lN4S/A1DxXFyu2UDAQIKXJpjYNpCdVyhtewkIU/gzmDiS95VnDOOh+s7C+93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608414; c=relaxed/simple;
	bh=ATbbnrx0TUObp47sVRlqLG9QZEVMDb5/otnSDEnSVMA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=d8WTIm2owpRS9al0z+UOdGyiF0kN7oBvybW17lijaFReJSlyE09mrHVRhZ7Ul2OirzkxI+Z61c+eFGNzSqvoxtdBjoa3GcoRnTRv2TPgQrXrlTbX22vsfRZN2f0KVNRwrQf+NzD6PPsiWPJwO6DtMR3kwI/B4zm1DPQ5uTWm6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qknzVQzs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g6i4VDXB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5p25HMeTLCfPpfbdlCDMeDawjU8D2mBQsAuPv6MO5SI=;
	b=qknzVQzs5oGQwePl83xXV8QekTC36ILbQGKdiC+GRqYaSioIxXnjvtPY7WM7CCf7SfRSjJ
	snMWV7+plWH6EpDv6tPTpj6YrcahG/roxAxq3um6g0FniXD5usjL7BY7aKEPXW8In3QHwj
	EG4kKqQIs87BsaddXqOSWImuRzYWEPPtbIuKR3zA1ObY4i+WGjNFsz6AawRLTo3PK/s81f
	6gZ6++Ak5hwtqp+VuxMR5nRNxsbFGW+vbNPN1DnqsFlpIFEZNbulzA+9aRB0fjdDMzeAAo
	M91wyhwbAfKQlvWl9Bfqi4Iwb3hJE8+/TidBogv4Mizw5BunUvZq7qDWq8oybw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5p25HMeTLCfPpfbdlCDMeDawjU8D2mBQsAuPv6MO5SI=;
	b=g6i4VDXB79Ue+XlM7cRED20bv3RX3fk4TH7U+QLdfn7tftaB5WT8+DtYKMNhRUwrRn0Srw
	Ycs9bZgmWY2NWeCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] elfnote: Change ELFNOTE() to use __UNIQUE_ID()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060839201.709179.4524623285795260797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c2d420796a427dda71a2400909864e7f8e037fd4
Gitweb:        https://git.kernel.org/tip/c2d420796a427dda71a2400909864e7f8e0=
37fd4
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:15 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:22 -07:00

elfnote: Change ELFNOTE() to use __UNIQUE_ID()

In preparation for the objtool klp diff subcommand, replace the custom
unique symbol name generation in ELFNOTE() with __UNIQUE_ID().

This standardizes the naming format for all "unique" symbols, which will
allow objtool to properly correlate them.  Note this also removes the
"one ELF note per line" limitation.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/elfnote.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
index 69b136e..bb3dcde 100644
--- a/include/linux/elfnote.h
+++ b/include/linux/elfnote.h
@@ -60,23 +60,21 @@
=20
 #else	/* !__ASSEMBLER__ */
 #include <uapi/linux/elf.h>
+#include <linux/compiler.h>
 /*
  * Use an anonymous structure which matches the shape of
  * Elf{32,64}_Nhdr, but includes the name and desc data.  The size and
  * type of name and desc depend on the macro arguments.  "name" must
- * be a literal string, and "desc" must be passed by value.  You may
- * only define one note per line, since __LINE__ is used to generate
- * unique symbols.
+ * be a literal string, and "desc" must be passed by value.
  */
-#define _ELFNOTE_PASTE(a,b)	a##b
-#define _ELFNOTE(size, name, unique, type, desc)			\
+#define ELFNOTE(size, name, type, desc)					\
 	static const struct {						\
 		struct elf##size##_note _nhdr;				\
 		unsigned char _name[sizeof(name)]			\
 		__attribute__((aligned(sizeof(Elf##size##_Word))));	\
 		typeof(desc) _desc					\
 			     __attribute__((aligned(sizeof(Elf##size##_Word)))); \
-	} _ELFNOTE_PASTE(_note_, unique)				\
+	} __UNIQUE_ID(note)						\
 		__used							\
 		__attribute__((section(".note." name),			\
 			       aligned(sizeof(Elf##size##_Word)),	\
@@ -89,11 +87,10 @@
 		name,							\
 		desc							\
 	}
-#define ELFNOTE(size, name, type, desc)		\
-	_ELFNOTE(size, name, __LINE__, type, desc)
=20
 #define ELFNOTE32(name, type, desc) ELFNOTE(32, name, type, desc)
 #define ELFNOTE64(name, type, desc) ELFNOTE(64, name, type, desc)
+
 #endif	/* __ASSEMBLER__ */
=20
 #endif /* _LINUX_ELFNOTE_H */

