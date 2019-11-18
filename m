Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D6EFFCCE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Nov 2019 02:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRBW7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 17 Nov 2019 20:22:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34977 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbfKRBW7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 17 Nov 2019 20:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574040177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuKKozoX2IaGiwfBygC66aUq6NMWEqsDHdKXFpwLIXU=;
        b=RvWNCzx3JTqwH0aW9c1xKKATQR0AISaGvzLcofhx3P4Bb6yeEwx9i3r+ifuh/D6tzsVDkW
        FoTsfweJtAycxVVw0i47ovXcO9SdHrMLwelhod7uR/18Dc4rBGYPeYLcIAcgrhX8qpmE8a
        jQfu9Bb+icRBleydAQilJNQOi50ze2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-B32kBpQdNrKDSGFJPojxsQ-1; Sun, 17 Nov 2019 20:22:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01969801FCF;
        Mon, 18 Nov 2019 01:22:52 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-229.rdu2.redhat.com [10.10.120.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E421A614F2;
        Mon, 18 Nov 2019 01:22:49 +0000 (UTC)
Subject: Re: [tip: x86/pti] x86/speculation: Fix redundant MDS mitigation
 message
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20191115161445.30809-3-longman@redhat.com>
 <157390711921.12247.3084878540998345444.tip-bot2@tip-bot2>
 <20191116142411.GA23231@zn.tnic>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <da0e6414-6992-b275-6a16-9b3c76cfd979@redhat.com>
Date:   Sun, 17 Nov 2019 20:22:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191116142411.GA23231@zn.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: B32kBpQdNrKDSGFJPojxsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 11/16/19 9:24 AM, Borislav Petkov wrote:
> On Sat, Nov 16, 2019 at 12:25:19PM -0000, tip-bot2 for Waiman Long wrote:
>> +static void __init mds_print_mitigation(void)
>> +{
>>  =09pr_info("%s\n", mds_strings[mds_mitigation]);
>>  }
> Almost. This causes
>
> MDS: Vulnerable
>
> to be printed on an in-order 32-bit Atom here, which is wrong. I've
> fixed it up to:
>
> ---
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index cb2fbd93ef4d..8bf64899f56a 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -256,6 +256,9 @@ static void __init mds_select_mitigation(void)
> =20
>  static void __init mds_print_mitigation(void)
>  {
> +=09if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
> +=09=09return;
> +
>  =09pr_info("%s\n", mds_strings[mds_mitigation]);
>  }
> =20
>
You are right. I missed that.

Thanks for fixing it.

Cheers,
Longman

