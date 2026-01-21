Return-Path: <linux-tip-commits+bounces-8090-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGI9KgE7cWnKfQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8090-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 21:45:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F3C5D878
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 21:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6388874681E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082A3A7F6E;
	Wed, 21 Jan 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HFBR4KbH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ksH8C/k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139E329C6B;
	Wed, 21 Jan 2026 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769023731; cv=none; b=be3MwqbZby06ww0NlY029JlS8q+oj9eP7hD5fKEQJQYlE537oK8Dz49Bgqz/ZuzqLsjY3lqs4a7VzGW3wBiBzX6GmZ1xmav8wapK2myZg2gPOvg2EBwLThUtbzaVpP0aI6ORAB2iqXhM0tNyhjwLyg+9Gw7+tabVZ2vIGa2VpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769023731; c=relaxed/simple;
	bh=vDtu4tsLJJpKLdshx8lbIt2iCEza4vEkjFSvBsqLbJw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AT5ygEFik6h0+25PkSg/VePDyA5dPjNmQClvJcNyaTN8gVuFIg54uAk3oqnyM3flHX4ESFlkuJoc0sS5NbTgbEubOz/k7anSVSbgCPmqo3Etl/xD8i5t923wd39Oy9/c48Nt/CuILsGq8TBygnUI0OZskDCyjmTCSy1sBRWfWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HFBR4KbH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ksH8C/k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Jan 2026 19:28:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769023722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhUHOIwKOIGQ7e/rhpCLnh1g+lS0qeOrqVRWyJWHR/Y=;
	b=HFBR4KbHTftyiHtd+tytDx+FV/BcElwPoN/eZKgbbPxVEe+rP5I/sqh/FRyxQ3H7LRNjyz
	+9/3AVKUlnMQk/1CvllOs/mUrdpzY/fM2QLW/siima8JSlAIfIH3uSGRpEjEjo5wvd8UBE
	4O/JzcmcVNlHuE7TogbYs+cOQUpllskA2IDqQcyDu6IABoPjHgfshM7KszacfBVTKV9yKm
	gz9rXHh+WVAUH23zePM1ImOeSjfRYRgNFW44pbVJiX1qJruEygrhRzf0B5Pm8xnJi8NaJ1
	VSy9OpyskzCLwwoAjQiiVpl+NnuDEUsg/eQ9lyv9sfthg2B0W5U7k1cfRQyz4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769023722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhUHOIwKOIGQ7e/rhpCLnh1g+lS0qeOrqVRWyJWHR/Y=;
	b=6ksH8C/k5gdmYZxj4Szrh0vcCW30xI0wX22E6TClZIYghvlfw79oCRW2EP8kMT0cqmUb7U
	eVNtw3eJ0oOTyTBQ==
From: "tip-bot2 for Sasha Levin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Fix libopcodes linking with static libraries
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sasha Levin <sashal@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121162532.1596238-1-sashal@kernel.org>
References: <20260121162532.1596238-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176902372065.510.12809888165013587029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url,vger.kernel.org:replyto];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8090-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 69F3C5D878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     3f2de814c0597c97d5abe09a1635d8c4e2fddaf2
Gitweb:        https://git.kernel.org/tip/3f2de814c0597c97d5abe09a1635d8c4e2f=
ddaf2
Author:        Sasha Levin <sashal@kernel.org>
AuthorDate:    Wed, 21 Jan 2026 11:25:32 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Jan 2026 20:25:14 +01:00

objtool: Fix libopcodes linking with static libraries

Commit 436326bc525d ("objtool: fix build failure due to missing libopcodes
check") tests for libopcodes using an empty main(), which passes even when
static libraries lack their dependencies. This causes undefined reference
errors (xmalloc, bfd_get_bits, etc.) when linking against static libopcodes
without its required libbfd and libiberty.

Fix by testing with an actual libopcodes symbol and trying increasingly
complete library combinations until one succeeds.

Fixes: 436326bc525d ("objtool: fix build failure due to missing libopcodes ch=
eck")
Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Link: https://patch.msgid.link/20260121162532.1596238-1-sashal@kernel.org
---
 tools/objtool/Makefile | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 9b45031..a40f302 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -77,8 +77,21 @@ HOST_OVERRIDES :=3D CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)" AR=
=3D"$(HOSTAR)"
 # We check using HOSTCC directly rather than the shared feature framework
 # because objtool is a host tool that links against host libraries.
 #
-HAVE_LIBOPCODES :=3D $(shell echo 'int main(void) { return 0; }' | \
-			$(HOSTCC) -xc - -o /dev/null -lopcodes 2>/dev/null && echo y)
+# When using shared libraries, -lopcodes is sufficient as dependencies are
+# resolved automatically. With static libraries, we must explicitly link
+# against libopcodes' dependencies: libbfd, libiberty, and sometimes libz.
+# Try each combination and use the first one that succeeds.
+#
+LIBOPCODES_LIBS :=3D $(shell \
+	for libs in "-lopcodes" \
+		    "-lopcodes -lbfd" \
+		    "-lopcodes -lbfd -liberty" \
+		    "-lopcodes -lbfd -liberty -lz"; do \
+		echo 'extern void disassemble_init_for_target(void *);' \
+		     'int main(void) { disassemble_init_for_target(0); return 0; }' | \
+			$(HOSTCC) -xc - -o /dev/null $$libs 2>/dev/null && \
+			echo "$$libs" && break; \
+	done)
=20
 # Styled disassembler support requires binutils >=3D 2.39
 HAVE_DISASM_STYLED :=3D $(shell echo '$(pound)include <dis-asm.h>' | \
@@ -86,10 +99,10 @@ HAVE_DISASM_STYLED :=3D $(shell echo '$(pound)include <di=
s-asm.h>' | \
=20
 BUILD_DISAS :=3D n
=20
-ifeq ($(HAVE_LIBOPCODES),y)
+ifneq ($(LIBOPCODES_LIBS),)
 	BUILD_DISAS :=3D y
 	OBJTOOL_CFLAGS +=3D -DDISAS -DPACKAGE=3D'"objtool"'
-	OBJTOOL_LDFLAGS +=3D -lopcodes
+	OBJTOOL_LDFLAGS +=3D $(LIBOPCODES_LIBS)
 ifeq ($(HAVE_DISASM_STYLED),y)
 	OBJTOOL_CFLAGS +=3D -DDISASM_INIT_STYLED
 endif

