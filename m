Return-Path: <linux-tip-commits+bounces-8406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONZ8H3kmr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:58:49 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E742407AF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0339306DFE4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48E41B37B;
	Mon,  9 Mar 2026 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wI5h6RsI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uPFbDfTs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03831411610;
	Mon,  9 Mar 2026 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086059; cv=none; b=RGF7d6vdQcb7OaljFJ3mkqGA+7QV4qcTszOufyksVrho4Cclv4cx6lmGZqJj161j0w0qiUcayWlc3te6QzdYH1/yxcTsPaQpvV8uFMlOHKyDrFpU8a8z8U+V7sgpPFP9KW22gXq47iK4hxxvpl3e8Vd1u8SUDn95E6XCyYTD93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086059; c=relaxed/simple;
	bh=KeyeEez50MdQCKcN8Mkhypinc4mZZWRCU94NsP6SeEc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qeUDCeQOjSIW8Wx4n+4Hw0sV1ni8HfYQO9GA4KL6U4syN+LNOSbAykdvTIjJo+BV4/LTymen+Rfk9ZnIdYz4AM6w+ttK+Cd67DwSx3aq9HzNsdt1nBWDaGzR+oBIK2zMGct5UnSMwy+LNSDN7PV5lutFBDQCbH65enqAxWD1LIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wI5h6RsI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uPFbDfTs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:54:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53DH0jqkskUysWuU5og2Lik36jZYzjQ2+xZtXhgye2g=;
	b=wI5h6RsICqn+akh+ED1LVWQmvDmM0f0adQCw/W3VeFcekAItlO3fXpEmhlUWinItr6JnIJ
	cIxKpuLwDHnCi+sQoiGbVDJc30qBmmwft1Sjr9KUNguyhLQ0pqTILc2ygZ3xXek5Sqv6Mk
	IZfW4MffAW8TkR0Bz1otyJciryo3fVdxDKcq6rSWbx4xh4YHu2l6v1FV98P0JwJ+NBnb9v
	fFF3fMOW+kh75CoiKO3/dhM6eW9rgMUQUHapiSEyXwFlA1lrGfxVWp8XVefhkquXNPyheQ
	aI0Ge8Nt520dk+g6M33Rb6cg0vuQATnJQFMHVRIjsSErtiXZ5r0xN0PvYuamXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53DH0jqkskUysWuU5og2Lik36jZYzjQ2+xZtXhgye2g=;
	b=uPFbDfTsug7bBtf4V8a+QfvzMuvNVLuMzc/WAUfPJGaeS7yvQh4WRM9cNqQI4JNrcQVOaf
	jjSgo4nDeIlMZMDQ==
From: "tip-bot2 for HONG Yifan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Use HOSTCFLAGS for HAVE_XXHASH test
Cc: HONG Yifan <elsk@google.com>, Carlos Llamas <cmllamas@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303010340.306164-1-elsk@google.com>
References: <20260303010340.306164-1-elsk@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308605560.1647592.16563099623328869266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E8E742407AF
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8406-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     32234049107d012703d50547e815f198f147968b
Gitweb:        https://git.kernel.org/tip/32234049107d012703d50547e815f198f14=
7968b
Author:        HONG Yifan <elsk@google.com>
AuthorDate:    Tue, 03 Mar 2026 01:03:39=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 07:48:41 -08:00

objtool: Use HOSTCFLAGS for HAVE_XXHASH test

Previously, HAVE_XXHASH is tested by invoking HOSTCC without HOSTCFLAGS.

Consider the following scenario:

- The host machine has libxxhash installed
- We build the kernel with HOSTCFLAGS containing a --sysroot that does
  not have xxhash.h (for hermetic builds)

In this case, HAVE_XXHASH is set to y, but when it builds objtool with
HOSTCFLAGS, because the --sysroot does not contain xxhash.h, the
following error is raised:

<...>/common/tools/objtool/include/objtool/checksum_types.h:12:10: fatal erro=
r: 'xxhash.h' file not found
   12 | #include <xxhash.h>
      |          ^~~~~~~~~~

To resolve the error, we test HAVE_XXHASH by invoking HOSTCC with
HOSTCFLAGS.

Signed-off-by: HONG Yifan <elsk@google.com>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Link: https://patch.msgid.link/20260303010340.306164-1-elsk@google.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 6964175..b8b8529 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -13,7 +13,7 @@ endif
=20
 ifeq ($(ARCH_HAS_KLP),y)
 	HAVE_XXHASH =3D $(shell printf "$(pound)include <xxhash.h>\nXXH3_state_t *s=
tate;int main() {}" | \
-		      $(HOSTCC) -xc - -o /dev/null -lxxhash 2> /dev/null && echo y || echo=
 n)
+		      $(HOSTCC) $(HOSTCFLAGS) -xc - -o /dev/null -lxxhash 2> /dev/null && =
echo y || echo n)
 	ifeq ($(HAVE_XXHASH),y)
 		BUILD_KLP	 :=3D y
 		LIBXXHASH_CFLAGS :=3D $(shell $(HOSTPKG_CONFIG) libxxhash --cflags 2>/dev/=
null) \

