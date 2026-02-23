Return-Path: <linux-tip-commits+bounces-8233-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AXHG2UsnGkKAgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8233-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:31:01 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124EB174E98
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57C8D300613C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C6343D83;
	Mon, 23 Feb 2026 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUfH86R2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k8F2+EkC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CB35B12B;
	Mon, 23 Feb 2026 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842654; cv=none; b=f6TYBX5Is8ktCzb8HOCutMDQjWsxwqumwu22V7WHP3Z7L9TwPByJ51ll+F+oXOKO3TlGjfH+smEUWn1lFeVWjIyS0bNjT+JKbo532BxQHVPNNgM/q7jJlfU1uC6fcnLvCNTfcxRSHiJehdW4I5cqgLMPg/0DxRcmUltYbaBpsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842654; c=relaxed/simple;
	bh=M9diRFznXcXmBfxMXX7ztwSwCReb10Zp+g6s7aA/O9o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LlTMWYkdzZ7AtHXDrXD2jCP3YdYXm/qJQdarw0MzAw9hQ7r4zFcGQ1pnU5N96ZJtnhIRmKulW/Qs1tjf9TQlIJlUiAdO5gVHW6ZkX+7o0aFnS9s+VvpnNHfHTtdPuhDUJmSftYLs6FL87YLSt3uD0y6NTCsRegv+onA44dFDdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUfH86R2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k8F2+EkC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:30:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0r9UPk2Sn//YlWCmwazimDNfRiVZcHE8j0nPBBSshww=;
	b=rUfH86R2fefq+CxmK+25kEZuvEgKMlIzJNRusb5cF2RgoMKu4qK0WG6qk4wbEKocCZgHqk
	6tkiehEmHW8kq8iL3H6Eq1DqPylDGEr6//NRDCZ2mOIdNleNnnhVxp0SEMkpnrDtuaQNKA
	342a1EGx0YeFpith4Jjk8M3/KMD5ycVTeh24ctdDSFL/PLoHTnMhKtYZJAGYeK1bKDHARI
	0HvuvNXa/ZP1MOE/9DML2kDOc2OMWakrNM+jyrcYnsSAEysnBHw6fUne0dC4DrakTgqXd7
	5xwDyCEqN7yAuWQOaeLxTJsO/ArLSbTM2ag1t9GJmOh118vMRmM7EKeolhnmpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0r9UPk2Sn//YlWCmwazimDNfRiVZcHE8j0nPBBSshww=;
	b=k8F2+EkCg9JsgYsshcsV/YbocF90Vu99xopFWpbSFMizl7e7cZU5IpncTryigBwiNL+BFo
	OVjgu5reAV0LAcAA==
From: "tip-bot2 for Haocheng Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Fix refcount bug and potential UAF in perf_mmap
Cc: kernel test robot <lkp@intel.com>, Haocheng Yu <yuhaocheng035@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260202162057.7237-1-yuhaocheng035@gmail.com>
References: <20260202162057.7237-1-yuhaocheng035@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184265018.1647592.7732005200099173227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8233-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim,intel.com:email,msgid.link:url,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 124EB174E98
X-Rspamd-Action: no action

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     77de62ad3de3967818c3dbe656b7336ebee461d2
Gitweb:        https://git.kernel.org/tip/77de62ad3de3967818c3dbe656b7336ebee=
461d2
Author:        Haocheng Yu <yuhaocheng035@gmail.com>
AuthorDate:    Tue, 03 Feb 2026 00:20:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:25 +01:00

perf/core: Fix refcount bug and potential UAF in perf_mmap

Syzkaller reported a refcount_t: addition on 0; use-after-free warning
in perf_mmap.

The issue is caused by a race condition between a failing mmap() setup
and a concurrent mmap() on a dependent event (e.g., using output
redirection).

In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
event->rb with the mmap_mutex held. The mutex is then released to
perform map_range().

If map_range() fails, perf_mmap_close() is called to clean up.
However, since the mutex was dropped, another thread attaching to
this event (via inherited events or output redirection) can acquire
the mutex, observe the valid event->rb pointer, and attempt to
increment its reference count. If the cleanup path has already
dropped the reference count to zero, this results in a
use-after-free or refcount saturation warning.

Fix this by extending the scope of mmap_mutex to cover the
map_range() call. This ensures that the ring buffer initialization
and mapping (or cleanup on failure) happens atomically effectively,
preventing other threads from accessing a half-initialized or
dying ring buffer.

Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel=
.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260202162057.7237-1-yuhaocheng035@gmail.com
---
 kernel/events/core.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f86d22..22a0f40 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7465,28 +7465,28 @@ static int perf_mmap(struct file *file, struct vm_are=
a_struct *vma)
 			ret =3D perf_mmap_aux(vma, event, nr_pages);
 		if (ret)
 			return ret;
-	}
=20
-	/*
-	 * Since pinned accounting is per vm we cannot allow fork() to copy our
-	 * vma.
-	 */
-	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops =3D &perf_mmap_vmops;
+		/*
+		 * Since pinned accounting is per vm we cannot allow fork() to copy our
+		 * vma.
+		 */
+		vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
+		vma->vm_ops =3D &perf_mmap_vmops;
=20
-	mapped =3D get_mapped(event, event_mapped);
-	if (mapped)
-		mapped(event, vma->vm_mm);
+		mapped =3D get_mapped(event, event_mapped);
+		if (mapped)
+			mapped(event, vma->vm_mm);
=20
-	/*
-	 * Try to map it into the page table. On fail, invoke
-	 * perf_mmap_close() to undo the above, as the callsite expects
-	 * full cleanup in this case and therefore does not invoke
-	 * vmops::close().
-	 */
-	ret =3D map_range(event->rb, vma);
-	if (ret)
-		perf_mmap_close(vma);
+		/*
+		 * Try to map it into the page table. On fail, invoke
+		 * perf_mmap_close() to undo the above, as the callsite expects
+		 * full cleanup in this case and therefore does not invoke
+		 * vmops::close().
+		 */
+		ret =3D map_range(event->rb, vma);
+		if (ret)
+			perf_mmap_close(vma);
+	}
=20
 	return ret;
 }

