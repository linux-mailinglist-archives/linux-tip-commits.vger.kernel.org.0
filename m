Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E094F437C5B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhJVSBQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 14:01:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40816 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhJVSBQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 14:01:16 -0400
Date:   Fri, 22 Oct 2021 17:58:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634925537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCcpap8OVe3PPIHU8LWOB8VyXxCtSLtVw5cEKKnSTnY=;
        b=dJ/e1xxyzXGJiMBwcbtyXwJLka6n310ezkco2TK9nWQGnYixLyrmbaWe2cV28TIBGGitOj
        ZAYQqP1pO08wvB7G1sVRN0HvSJw5TmWPrcVbGuiU7fSy1IP5suN98rwL+pUqmL6ytx1pdp
        u7itTOu0ig6Rru4VmSH79wl+NVjQW7pcMnuybY77f6nPu1EB5Wy384+SEkMIbjwYgNB/Jt
        pbVcKJ6eOyIrGd7UUdF7qqSWFdko4Ke8tRHnkgtRwEKG387sgniXiAafVchj3y+IoRF1Qw
        YWvXpdInoUtclpe1efS7gjH8mvLHl/zk0C73wYWGvca4PklIifqJQofN9Q261Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634925537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCcpap8OVe3PPIHU8LWOB8VyXxCtSLtVw5cEKKnSTnY=;
        b=bjRBRef1aHst1RhocHLaaOQwFA+QrqmzNXQfiQpqdDjK3RJ12MIaa+RIKr3UEaGUZvi7kd
        Zgu3Sa3lnXt0uyDA==
From:   "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx/virt: implement SGX_IOC_VEPC_REMOVE ioctl
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021201155.1523989-3-pbonzini@redhat.com>
References: <20211021201155.1523989-3-pbonzini@redhat.com>
MIME-Version: 1.0
Message-ID: <163492553586.626.6203146268884288075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     ae095b16fc652f459e6c16a256834985c85ecc4d
Gitweb:        https://git.kernel.org/tip/ae095b16fc652f459e6c16a256834985c85ecc4d
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Thu, 21 Oct 2021 16:11:55 -04:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Oct 2021 08:32:12 -07:00

x86/sgx/virt: implement SGX_IOC_VEPC_REMOVE ioctl

For bare-metal SGX on real hardware, the hardware provides guarantees
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20211021201155.1523989-3-pbonzini@redhat.com
---
 Documentation/x86/sgx.rst       | 35 +++++++++++++++++++++-
 arch/x86/include/uapi/asm/sgx.h |  2 +-
 arch/x86/kernel/cpu/sgx/virt.c  | 53 ++++++++++++++++++++++++++++++++-
 3 files changed, 90 insertions(+)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index dd0ac96..a608f66 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -250,3 +250,38 @@ user wants to deploy SGX applications both on the host and in guests
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
+``EREMOVE`` can fail for three reasons.  Userspace must pay attention
+to expected failures and handle them as follows:
+
+1. Page removal will always fail when any thread is running in the
+   enclave to which the page belongs.  In this case the ioctl will
+   return ``EBUSY`` independent of whether it has successfully removed
+   some pages; userspace can avoid these failures by preventing execution
+   of any vcpu which maps the virtual EPC.
+
+2. Page removal will cause a general protection fault if two calls to
+   ``EREMOVE`` happen concurrently for pages that refer to the same
+   "SECS" metadata pages.  This can happen if there are concurrent
+   invocations to ``SGX_IOC_VEPC_REMOVE_ALL``, or if a ``/dev/sgx_vepc``
+   file descriptor in the guest is closed at the same time as
+   ``SGX_IOC_VEPC_REMOVE_ALL``; it will also be reported as ``EBUSY``.
+   This can be avoided in userspace by serializing calls to the ioctl()
+   and to close(), but in general it should not be a problem.
+
+3. Finally, page removal will fail for SECS metadata pages which still
+   have child pages.  Child pages can be removed by executing
+   ``SGX_IOC_VEPC_REMOVE_ALL`` on all ``/dev/sgx_vepc`` file descriptors
+   mapped into the guest.  This means that the ioctl() must be called
+   twice: an initial set of calls to remove child pages and a subsequent
+   set of calls to remove SECS pages.  The second set of calls is only
+   required for those mappings that returned a nonzero value from the
+   first call.  It indicates a bug in the kernel or the userspace client
+   if any of the second round of ``SGX_IOC_VEPC_REMOVE_ALL`` calls has
+   a return code other than 0.
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
index 59cdf3f..6a77a14 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -150,6 +150,41 @@ static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
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
+		if (ret) {
+			if (ret == SGX_CHILD_PRESENT) {
+				/* The page is a SECS, userspace will retry.  */
+				failures++;
+			} else {
+				/*
+				 * Report errors due to #GP or SGX_ENCLAVE_ACT; do not
+				 * WARN, as userspace can induce said failures by
+				 * calling the ioctl concurrently on multiple vEPCs or
+				 * while one or more CPUs is running the enclave.  Only
+				 * a #PF on EREMOVE indicates a kernel/hardware issue.
+				 */
+				WARN_ON_ONCE(encls_faulted(ret) &&
+					     ENCLS_TRAPNR(ret) != X86_TRAP_GP);
+				return -EBUSY;
+			}
+		}
+		cond_resched();
+	}
+
+	/*
+	 * Return the number of SECS pages that failed to be removed, so
+	 * userspace knows that it has to retry.
+	 */
+	return failures;
+}
+
 static int sgx_vepc_release(struct inode *inode, struct file *file)
 {
 	struct sgx_vepc *vepc = file->private_data;
@@ -235,9 +270,27 @@ static int sgx_vepc_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static long sgx_vepc_ioctl(struct file *file,
+			   unsigned int cmd, unsigned long arg)
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
