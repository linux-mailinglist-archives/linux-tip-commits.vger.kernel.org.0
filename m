Return-Path: <linux-tip-commits+bounces-6931-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C4ABE2991
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4628B355AFB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36531340D9F;
	Thu, 16 Oct 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2H9d72M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2KumDQgs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469F32F75D;
	Thu, 16 Oct 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608426; cv=none; b=dKvZvGFiBYNyyWA2ruU6+7NRgUex0+ROABwcgxYwGELWHNuJQOwhrGQkiSAXS6z7jhTYBdVQBoSrcpoSgkOHGFBN3k6efe5Ty9UapDZVq/gO4WLopd8fPm4/zFAHoJ23KqooQJy5Z7ZoQRTHajWUa7QzqaNq4WdpDSGTQjLp/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608426; c=relaxed/simple;
	bh=WRlPRzhfuQgdhyLSIW+CU/gXyoDKtpIwiZRr7ip9xWA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=H/q2yrsnmSNIVsfXxxHRfUql8DfnHOI3MnOv7GjgAhMYs2WvFqJWpmuYMWS31dEJzIY37e0fa2xm8Jh8Rjya/tvffpG1yfPwe61ZH5GXQgqJZY/BM/U+Ia7UQNGPfcflFgmMolRxdVi8pBThEuRpRQAh8J58b5kW1cByb/M0Yoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2H9d72M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2KumDQgs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5qweveWRseaJNRF9rCTBrtI234KwHJMEEOIKMDQZZTs=;
	b=A2H9d72MUisWLwjfHfV80n72Jt840TgZjhXszMqoVe8SgW+c9z1HQaZaXwmrbGWURIUtjb
	wyAwmbkUWA/MwlVdDtaaEh0dkUSiaiKKR8vbDGiKIB7KZbNFBK0b7p1Fq63uTn++RUsfJO
	VBAD0CwVD96bq815wID018o+pRM9yLjDOdQWh76qSxt+Noyrw6zTSlnY5be012YV2D0a1r
	SV2VmmUQ+uSi2HEZaVEevfvplT+OmJxdzlyB5sqTFcHfnkd4HLhSvVAWorZYSH8pC5e5/I
	gP8w683WVzSQHTp4czTziXOklyZ/I3r06DwV60Syv7m6fZXVtyXMPoGrNrpB2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5qweveWRseaJNRF9rCTBrtI234KwHJMEEOIKMDQZZTs=;
	b=2KumDQgsyrJ9ng0eyfNVHGchhxHAxyA0F8L4YkaS9vFbO38AalaXvgEBip7+DtNupa9WYJ
	QLomXIw/iQ7EfjBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] tools build: Fix fixdep dependencies
Cc: Arthur Marsh <arthur.marsh@internode.on.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060840507.709179.15363439615733763867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a808a2b35f66658e6c49dc98b55a33fa1079fe72
Gitweb:        https://git.kernel.org/tip/a808a2b35f66658e6c49dc98b55a33fa107=
9fe72
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 17:01:42 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00

tools build: Fix fixdep dependencies

The tools version of fixdep has broken dependencies.  It doesn't get
rebuilt if the host compiler or headers change.

Build fixdep with the tools kbuild infrastructure, so fixdep runs on
itself.  Due to the recursive dependency, its dependency file is
incomplete the very first time it gets built.  In that case build it a
second time to achieve fixdep inception.

Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/build/Build    |  2 ++
 tools/build/Makefile | 23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/Build

diff --git a/tools/build/Build b/tools/build/Build
new file mode 100644
index 0000000..1c7e598
--- /dev/null
+++ b/tools/build/Build
@@ -0,0 +1,2 @@
+hostprogs	:=3D fixdep
+fixdep-y	:=3D fixdep.o
diff --git a/tools/build/Makefile b/tools/build/Makefile
index 63ef218..a5b3c29 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -37,5 +37,24 @@ ifneq ($(wildcard $(TMP_O)),)
 	$(Q)$(MAKE) -C feature OUTPUT=3D$(TMP_O) clean >/dev/null
 endif
=20
-$(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
-	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<
+include $(srctree)/tools/build/Makefile.include
+
+FIXDEP		:=3D $(OUTPUT)fixdep
+FIXDEP_IN	:=3D $(OUTPUT)fixdep-in.o
+
+# To track fixdep's dependencies properly, fixdep needs to run on itself.
+# Build it twice the first time.
+$(FIXDEP_IN): FORCE
+	$(Q)if [ ! -f $(FIXDEP) ]; then						\
+		$(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(KBUILD_HOSTCFLAGS)";	\
+		rm -f $(FIXDEP).o;						\
+	fi
+	$(Q)$(MAKE) $(build)=3Dfixdep HOSTCFLAGS=3D"$(KBUILD_HOSTCFLAGS)"
+
+
+$(FIXDEP): $(FIXDEP_IN)
+	$(QUIET_LINK)$(HOSTCC) $(FIXDEP_IN) $(KBUILD_HOSTLDFLAGS) -o $@
+
+FORCE:
+
+.PHONY: FORCE

