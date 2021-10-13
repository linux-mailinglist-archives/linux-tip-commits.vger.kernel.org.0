Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF942C0B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Oct 2021 14:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhJMM6j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Oct 2021 08:58:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhJMM6j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Oct 2021 08:58:39 -0400
Date:   Wed, 13 Oct 2021 12:56:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634129794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Nm+nzMa68X/wrBkOvkMjLmOViE9gmFSjoU3qCmh5W8=;
        b=tK/I9Nm3n8EvNNN8CGFlGpr3sIPP0wdaor5I9cbzjF8+ZzRWXEdDzGayFxn7cdpNKLo7jt
        07zcbMrL7ly7Cm0s1o9OIK/o+pLe42H1vzJ5s4/KbhjUWB1ls/F5+fk8F34PGZG3PJnmHg
        nJkR81dZOk9QavwTzBLc4IbNXidXv1QjSQbKTijaPmT5jnDXJ+BkzvzzZiCOzNNSCtfGoC
        9+kmCA2e/f3ysC5CeLqo7xi2r3CuOamp1zMVzJDUG8ANUGGIeaHiLnGQxWUCUvWNJ0gyUi
        BxUiSNtKCsMbsxtmKvJEC52lrF2mZx2Jhdg7ZLkGwGsXnJAABukN7COJzdDZHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634129794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Nm+nzMa68X/wrBkOvkMjLmOViE9gmFSjoU3qCmh5W8=;
        b=zQNFsMFuqkrcdtT+30MNRkRcrTq4rEVqsHuqnt+zzsYbGZ8NBy6NmivEPN+hQY4HyOyKWb
        hb/7Ufb6WDTDtmBQ==
From:   "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx/virt: Implement SGX_IOC_VEPC_REMOVE ioctl
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211012105708.2070480-3-pbonzini@redhat.com>
References: <20211012105708.2070480-3-pbonzini@redhat.com>
MIME-Version: 1.0
Message-ID: <163412979290.25758.2405858058111244615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     71eba1c0939e3b1ad1b71fe0171de30e265437e3
Gitweb:        https://git.kernel.org/tip/71eba1c0939e3b1ad1b71fe0171de30e265437e3
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Tue, 12 Oct 2021 06:57:08 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 Oct 2021 11:57:53 +02:00

x86/sgx/virt: Implement SGX_IOC_VEPC_REMOVE ioctl

For bare-metal SGX on real hardware, the hardware provides guaranteed
SGX state at reboot.  For instance, all pages start out uninitialized.
The vepc driver provides a similar guarantee today for freshly-opened
vepc instances, but guests such as Windows expect all pages to be in
uninitialized state on startup, including after every guest reboot.

Some userspace implementations of virtual SGX would rather avoid having
to close and reopen the /dev/sgx_vepc file descriptor and re-mmap the
virtual EPC.  For example, they could sandbox themselves after the guest
starts and forbid further calls to open(), in order to mitigate exploits
from untrusted guests.

Therefore, add a ioctl that does this with EREMOVE.  Userspace can
invoke the ioctl to bring its vEPC pages back to uninitialized state.
There is a possibility that some pages fail to be removed if they are
SECS pages, and the child and SECS pages could be in separate vEPC
regions.  Therefore, the ioctl returns the number of EREMOVE failures,
telling userspace to try the ioctl again after it's done with all
vEPC regions.  A more verbose description of the correct usage and
the possible error conditions is documented in sgx.rst.

 [ bp: Minor massaging. ]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/20211012105708.2070480-3-pbonzini@redhat.com
---
 Documentation/x86/sgx.rst       | 26 +++++++++++++++-
 arch/x86/include/asm/sgx.h      |  3 ++-
 arch/x86/include/uapi/asm/sgx.h |  2 +-
 arch/x86/kernel/cpu/sgx/virt.c  | 57 ++++++++++++++++++++++++++++++++-
 4 files changed, 88 insertions(+)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index dd0ac96..7bc9c3b 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -250,3 +250,29 @@ user wants to deploy SGX applications both on the host and in guests
 on the same machine, the user should reserve enough EPC (by taking out
 total virtual EPC size of all SGX VMs from the physical EPC size) for
 host SGX applications so they can run with acceptable performance.
+
+Architectural behavior is to restore all EPC pages to an uninitialized
+state also after a guest reboot.  Because this state can be reached only
+through the privileged ``ENCLS[EREMOVE]`` instruction, ``/dev/sgx_vepc``
+provides the ``SGX_IOC_VEPC_REMOVE_ALL`` ioctl to execute the instruction
+on all pages in the virtual EPC.
+
+``EREMOVE`` can fail for two reasons, which Linux relays to userspace
+in a different manner:
+
+1. Page removal will always fail when any thread is running in the
+   enclave to which the page belongs.  In this case the ioctl will
+   return ``EBUSY`` independent of whether it has successfully removed
+   some pages; userspace can avoid these failures by preventing execution
+   of any vcpu which maps the virtual EPC.
+
+2) Page removal will also fail for SGX "SECS" metadata pages which still
+   have child pages.  Child pages can be removed by executing
+   ``SGX_IOC_VEPC_REMOVE_ALL`` on all ``/dev/sgx_vepc`` file descriptors
+   mapped into the guest.  This means that the ioctl() must be called
+   twice: an initial set of calls to remove child pages and a subsequent
+   set of calls to remove SECS pages.  The second set of calls is only
+   required for those mappings that returned a nonzero value from the
+   first call.  It indicates a bug in the kernel or the userspace client
+   if any of the second round of ``SGX_IOC_VEPC_REMOVE_ALL`` calls has
+   a return code other than 0.
diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 05f3e21..2e5d8c9 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -50,6 +50,8 @@ enum sgx_encls_function {
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
  * %SGX_CHILD_PRESENT		SECS has child pages present in the EPC.
+ * %SGX_ENCLAVE_ACT		One or more logical processors are executing
+ *				inside the enclave.
  * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
  *				public key does not match IA32_SGXLEPUBKEYHASH.
  * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
@@ -57,6 +59,7 @@ enum sgx_encls_function {
 enum sgx_return_code {
 	SGX_NOT_TRACKED			= 11,
 	SGX_CHILD_PRESENT		= 13,
+	SGX_ENCLAVE_ACT			= 14,
 	SGX_INVALID_EINITTOKEN		= 16,
 	SGX_UNMASKED_EVENT		= 128,
 };
diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 9690d68..f4b8158 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -27,6 +27,8 @@ enum sgx_page_flags {
 	_IOW(SGX_MAGIC, 0x02, struct sgx_enclave_init)
 #define SGX_IOC_ENCLAVE_PROVISION \
 	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
+#define SGX_IOC_VEPC_REMOVE_ALL \
+	_IO(SGX_MAGIC, 0x04)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 59cdf3f..4465253 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -150,6 +150,46 @@ static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
 	return 0;
 }
 
+static long sgx_vepc_remove_all(struct sgx_vepc *vepc)
+{
+	struct sgx_epc_page *entry;
+	unsigned long index;
+	long failures = 0;
+
+	xa_for_each(&vepc->page_array, index, entry) {
+		int ret = sgx_vepc_remove_page(entry);
+		switch (ret) {
+		case 0:
+			break;
+
+		case SGX_CHILD_PRESENT:
+			failures++;
+			break;
+
+		case SGX_ENCLAVE_ACT:
+			/*
+			 * Unlike in sgx_vepc_free_page, userspace could be calling
+			 * the ioctl while logical processors are running in the
+			 * enclave; do not warn.
+			 */
+			return -EBUSY;
+
+		default:
+			WARN_ONCE(1, EREMOVE_ERROR_MESSAGE, ret, ret);
+			failures++;
+			break;
+		}
+		cond_resched();
+	}
+
+	/*
+	 * Return the number of pages that failed to be removed, so
+	 * userspace knows that there are still SECS pages lying
+	 * around.
+	 */
+	return failures;
+}
+
 static int sgx_vepc_release(struct inode *inode, struct file *file)
 {
 	struct sgx_vepc *vepc = file->private_data;
@@ -235,9 +275,26 @@ static int sgx_vepc_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static long sgx_vepc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct sgx_vepc *vepc = file->private_data;
+
+	switch (cmd) {
+	case SGX_IOC_VEPC_REMOVE_ALL:
+		if (arg)
+			return -EINVAL;
+		return sgx_vepc_remove_all(vepc);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
 static const struct file_operations sgx_vepc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= sgx_vepc_open,
+	.unlocked_ioctl	= sgx_vepc_ioctl,
+	.compat_ioctl	= sgx_vepc_ioctl,
 	.release	= sgx_vepc_release,
 	.mmap		= sgx_vepc_mmap,
 };
