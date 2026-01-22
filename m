Return-Path: <linux-tip-commits+bounces-8109-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPzDBCH8cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8109-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:29:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E797365453
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCE6C685CA7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDF141C2FF;
	Thu, 22 Jan 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pddA6GyZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0FmECpIC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B940B6F4;
	Thu, 22 Jan 2026 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076976; cv=none; b=Wzy+sUKHZ8Z8CvBeepwoBE5Je9zSAORv8x6v297QvdWGnIKW/VEjSPg7WtM4EnPmbcloUFHmTDpx2OeuWrdy0Ik22FF9GxqDkZTkzPzQ/hPQ9+9qvOHrkOl8MgqRwlfCJCt6Nv8YKJgg+q59YsvuFG+bVfvZHcYfPQ6ebZQe+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076976; c=relaxed/simple;
	bh=bMhCCCZJd66oGI1Lxefy085sODm5AdwMMrbuJ/JoYWs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F6d/Iyeu8hMyJqo2yUToZAKHIuZFeatyN09bA7fJo0u1CkIG91lv/bjeDaD9WsGCY3angO8NmDfiItHDuC1JESCEikabg30FG8Go8yEMYE/K5aaftq//0juZDLcGhbKKdm87NGf1QkpP1jptObio+E2SB3mg7Mu4RhpbkAWiEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pddA6GyZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0FmECpIC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiYlY1Hl6JdyvRzVaSe+QXgVduS3AH6Xm90cJq9bNQY=;
	b=pddA6GyZo/Xb4Moy59WXbdJp5VQr1S1DYQtn81q7imuic/UEYJ8Y4m4AFxNE4ht3RE/loW
	Zl1mIoRtgAzV1b5/FX3dr543UkT3s/ALGhTfgLWinb8fS4Wi2x0iNXe+v9Nj/RII+b5yuR
	cPXeRMiXpMmkUokMs6cNU2XrFDZ41uXV1fVBcFh51Uo4tWpMxY091lxGFLTP5QR8/xsjwq
	JqG85rvkByKlwUIUytwoFHsPgCI3YuJjJCzSizgZif2MoPUlmx87o9CimtLRp9Cnqcbpa/
	L3utyZkSGhRJM3O2xYCw0XyjlCadf2ISlqfqZND3X9U/PrZ/6dMWGmHiYxABYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiYlY1Hl6JdyvRzVaSe+QXgVduS3AH6Xm90cJq9bNQY=;
	b=0FmECpICZDPnOaaqaFs4ZIGDKkk4gBB7QueqMMPtAi99KKe589uygYJyUm4Qr8lvFVxMic
	yWDByy4ByJfGBGCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] rseq: Add fields and constants for time slice extension
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155708.669472597@linutronix.de>
References: <20251215155708.669472597@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907696900.510.13393120120513557937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,infradead.org:email,linutronix.de:email,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8109-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: E797365453
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d7a5da7a0f7fa7ff081140c4f6f971db98882703
Gitweb:        https://git.kernel.org/tip/d7a5da7a0f7fa7ff081140c4f6f971db988=
82703
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:16 +01:00

rseq: Add fields and constants for time slice extension

Aside of a Kconfig knob add the following items:

   - Two flag bits for the rseq user space ABI, which allow user space to
     query the availability and enablement without a syscall.

   - A new member to the user space ABI struct rseq, which is going to be
     used to communicate request and grant between kernel and user space.

   - A rseq state struct to hold the kernel state of this

   - Documentation of the new mechanism

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251215155708.669472597@linutronix.de
---
 Documentation/userspace-api/index.rst |   1 +-
 Documentation/userspace-api/rseq.rst  | 135 +++++++++++++++++++++++++-
 include/linux/rseq_types.h            |  28 ++++-
 include/uapi/linux/rseq.h             |  38 +++++++-
 init/Kconfig                          |  12 ++-
 kernel/rseq.c                         |   7 +-
 6 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/rseq.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-=
api/index.rst
index 8a61ac4..fa0fe8a 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -21,6 +21,7 @@ System calls
    ebpf/index
    ioctl/index
    mseal
+   rseq
=20
 Security-related interfaces
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
diff --git a/Documentation/userspace-api/rseq.rst b/Documentation/userspace-a=
pi/rseq.rst
new file mode 100644
index 0000000..e1fdb0d
--- /dev/null
+++ b/Documentation/userspace-api/rseq.rst
@@ -0,0 +1,135 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Restartable Sequences
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Restartable Sequences allow to register a per thread userspace memory area
+to be used as an ABI between kernel and userspace for three purposes:
+
+ * userspace restartable sequences
+
+ * quick access to read the current CPU number, node ID from userspace
+
+ * scheduler time slice extensions
+
+Restartable sequences (per-cpu atomics)
+---------------------------------------
+
+Restartable sequences allow userspace to perform update operations on
+per-cpu data without requiring heavyweight atomic operations. The actual
+ABI is unfortunately only available in the code and selftests.
+
+Quick access to CPU number, node ID
+-----------------------------------
+
+Allows to implement per CPU data efficiently. Documentation is in code and
+selftests. :(
+
+Scheduler time slice extensions
+-------------------------------
+
+This allows a thread to request a time slice extension when it enters a
+critical section to avoid contention on a resource when the thread is
+scheduled out inside of the critical section.
+
+The prerequisites for this functionality are:
+
+    * Enabled in Kconfig
+
+    * Enabled at boot time (default is enabled)
+
+    * A rseq userspace pointer has been registered for the thread
+
+The thread has to enable the functionality via prctl(2)::
+
+    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
+
+prctl() returns 0 on success or otherwise with the following error codes:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Errorcode Meaning
+=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+EINVAL	  Functionality not available or invalid function arguments.
+          Note: arg4 and arg5 must be zero
+ENOTSUPP  Functionality was disabled on the kernel command line
+ENXIO	  Available, but no rseq user struct registered
+=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The state can be also queried via prctl(2)::
+
+  prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_GET, 0, 0, 0);
+
+prctl() returns ``PR_RSEQ_SLICE_EXT_ENABLE`` when it is enabled or 0 if
+disabled. Otherwise it returns with the following error codes:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Errorcode Meaning
+=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+EINVAL	  Functionality not available or invalid function arguments.
+          Note: arg3 and arg4 and arg5 must be zero
+=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The availability and status is also exposed via the rseq ABI struct flags
+field via the ``RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT`` and the
+``RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT``. These bits are read-only for user
+space and only for informational purposes.
+
+If the mechanism was enabled via prctl(), the thread can request a time
+slice extension by setting rseq::slice_ctrl::request to 1. If the thread is
+interrupted and the interrupt results in a reschedule request in the
+kernel, then the kernel can grant a time slice extension and return to
+userspace instead of scheduling out. The length of the extension is
+determined by the ``rseq_slice_extension_nsec`` sysctl.
+
+The kernel indicates the grant by clearing rseq::slice_ctrl::request and
+setting rseq::slice_ctrl::granted to 1. If there is a reschedule of the
+thread after granting the extension, the kernel clears the granted bit to
+indicate that to userspace.
+
+If the request bit is still set when the leaving the critical section,
+userspace can clear it and continue.
+
+If the granted bit is set, then userspace invokes rseq_slice_yield(2) when
+leaving the critical section to relinquish the CPU. The kernel enforces
+this by arming a timer to prevent misbehaving userspace from abusing this
+mechanism.
+
+If both the request bit and the granted bit are false when leaving the
+critical section, then this indicates that a grant was revoked and no
+further action is required by userspace.
+
+The required code flow is as follows::
+
+    rseq->slice_ctrl.request =3D 1;
+    barrier();  // Prevent compiler reordering
+    critical_section();
+    barrier();  // Prevent compiler reordering
+    rseq->slice_ctrl.request =3D 0;
+    if (rseq->slice_ctrl.granted)
+        rseq_slice_yield();
+
+As all of this is strictly CPU local, there are no atomicity requirements.
+Checking the granted state is racy, but that cannot be avoided at all::
+
+    if (rseq->slice_ctrl.granted)
+      -> Interrupt results in schedule and grant revocation
+        rseq_slice_yield();
+
+So there is no point in pretending that this might be solved by an atomic
+operation.
+
+If the thread issues a syscall other than rseq_slice_yield(2) within the
+granted timeslice extension, the grant is also revoked and the CPU is
+relinquished immediately when entering the kernel. This is required as
+syscalls might consume arbitrary CPU time until they reach a scheduling
+point when the preemption model is either NONE or VOLUNTARY and therefore
+might exceed the grant by far.
+
+The preferred solution for user space is to use rseq_slice_yield(2) which
+is side effect free. The support for arbitrary syscalls is required to
+support onion layer architectured applications, where the code handling the
+critical section and requesting the time slice extension has no control
+over the code within the critical section.
+
+The kernel enforces flag consistency and terminates the thread with SIGSEGV
+if it detects a violation.
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 332dc14..67e40c0 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -73,12 +73,35 @@ struct rseq_ids {
 };
=20
 /**
+ * union rseq_slice_state - Status information for rseq time slice extension
+ * @state:	Compound to access the overall state
+ * @enabled:	Time slice extension is enabled for the task
+ * @granted:	Time slice extension was granted to the task
+ */
+union rseq_slice_state {
+	u16			state;
+	struct {
+		u8		enabled;
+		u8		granted;
+	};
+};
+
+/**
+ * struct rseq_slice - Status information for rseq time slice extension
+ * @state:	Time slice extension state
+ */
+struct rseq_slice {
+	union rseq_slice_state	state;
+};
+
+/**
  * struct rseq_data - Storage for all rseq related data
  * @usrptr:	Pointer to the registered user space RSEQ memory
  * @len:	Length of the RSEQ region
- * @sig:	Signature of critial section abort IPs
+ * @sig:	Signature of critical section abort IPs
  * @event:	Storage for event management
  * @ids:	Storage for cached CPU ID and MM CID
+ * @slice:	Storage for time slice extension data
  */
 struct rseq_data {
 	struct rseq __user		*usrptr;
@@ -86,6 +109,9 @@ struct rseq_data {
 	u32				sig;
 	struct rseq_event		event;
 	struct rseq_ids			ids;
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+	struct rseq_slice		slice;
+#endif
 };
=20
 #else /* CONFIG_RSEQ */
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 1b76d50..6afc219 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -23,9 +23,15 @@ enum rseq_flags {
 };
=20
 enum rseq_cs_flags_bit {
+	/* Historical and unsupported bits */
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	=3D 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	=3D 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	=3D 2,
+	/* (3) Intentional gap to put new bits into a separate byte */
+
+	/* User read only feature flags */
+	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	=3D 4,
+	RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT	=3D 5,
 };
=20
 enum rseq_cs_flags {
@@ -35,6 +41,11 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=3D
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+
+	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE	=3D
+		(1U << RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT),
+	RSEQ_CS_FLAG_SLICE_EXT_ENABLED		=3D
+		(1U << RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT),
 };
=20
 /*
@@ -53,6 +64,27 @@ struct rseq_cs {
 	__u64 abort_ip;
 } __attribute__((aligned(4 * sizeof(__u64))));
=20
+/**
+ * rseq_slice_ctrl - Time slice extension control structure
+ * @all:	Compound value
+ * @request:	Request for a time slice extension
+ * @granted:	Granted time slice extension
+ *
+ * @request is set by user space and can be cleared by user space or kernel
+ * space.  @granted is set and cleared by the kernel and must only be read
+ * by user space.
+ */
+struct rseq_slice_ctrl {
+	union {
+		__u32		all;
+		struct {
+			__u8	request;
+			__u8	granted;
+			__u16	__reserved;
+		};
+	};
+};
+
 /*
  * struct rseq is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line.
@@ -142,6 +174,12 @@ struct rseq {
 	__u32 mm_cid;
=20
 	/*
+	 * Time slice extension control structure. CPU local updates from
+	 * kernel and user space.
+	 */
+	struct rseq_slice_ctrl slice_ctrl;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
diff --git a/init/Kconfig b/init/Kconfig
index fa79feb..00c6fbb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1938,6 +1938,18 @@ config RSEQ
=20
 	  If unsure, say Y.
=20
+config RSEQ_SLICE_EXTENSION
+	bool "Enable rseq-based time slice extension mechanism"
+	depends on RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS
+	help
+	  Allows userspace to request a limited time slice extension when
+	  returning from an interrupt to user space via the RSEQ shared
+	  data ABI. If granted, that allows to complete a critical section,
+	  so that other threads are not stuck on a conflicted resource,
+	  while the task is scheduled out.
+
+	  If unsure, say N.
+
 config RSEQ_STATS
 	default n
 	bool "Enable lightweight statistics of restartable sequences" if EXPERT
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 395d8b0..07c324d 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -389,6 +389,8 @@ static bool rseq_reset_ids(void)
  */
 SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags,=
 u32, sig)
 {
+	u32 rseqfl =3D 0;
+
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
@@ -440,6 +442,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rs=
eq_len, int, flags, u32
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
=20
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
+		rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+
 	scoped_user_write_access(rseq, efault) {
 		/*
 		 * If the rseq_cs pointer is non-NULL on registration, clear it to
@@ -449,11 +454,13 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, =
rseq_len, int, flags, u32
 		 * clearing the fields. Don't bother reading it, just reset it.
 		 */
 		unsafe_put_user(0UL, &rseq->rseq_cs, efault);
+		unsafe_put_user(rseqfl, &rseq->flags, efault);
 		/* Initialize IDs in user space */
 		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id_start, efault);
 		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id, efault);
 		unsafe_put_user(0U, &rseq->node_id, efault);
 		unsafe_put_user(0U, &rseq->mm_cid, efault);
+		unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
 	}
=20
 	/*

