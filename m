Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F47AB078
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Sep 2023 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjIVLTT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Sep 2023 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjIVLTO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Sep 2023 07:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE3102
        for <linux-tip-commits@vger.kernel.org>; Fri, 22 Sep 2023 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695381504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GiW7xPy++se+q6i0olY89hLKZg8oY2P2U269iGcbHgc=;
        b=Ix8hjxU+S9Va6ICSIM23qKpZU+x/UF031ZMdqBG5jl4BFqN/8IbDMEzVzeQWSLp7wb9ptV
        6PnORp7dPe1MqnwAPYOSC83I6utqEdBVq85q5K+sDq6rK0x+BwkLEPCoLix81ZqWLWL89C
        9V6feB/Q/+nxJFlcyleekNeAy2gGkQU=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-PUFsTxA6PjCp06ZFJXSHXA-1; Fri, 22 Sep 2023 07:18:22 -0400
X-MC-Unique: PUFsTxA6PjCp06ZFJXSHXA-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-45289b05c67so860405137.2
        for <linux-tip-commits@vger.kernel.org>; Fri, 22 Sep 2023 04:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381501; x=1695986301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiW7xPy++se+q6i0olY89hLKZg8oY2P2U269iGcbHgc=;
        b=ftJU8b+4F/kNkh0iYlCVEO7vL4NGL9yhNywtk2ywsAQgfSseOPsx1+D6JFeni5rsxU
         BjPFVIpeHBzRTi0fKPTP446wGoIypDEDz2cXe+9fDIHofhlNfQ+SaaEvWHwqK90IHuUm
         omOCLo/3VGELWmJlS89ros5IVK0oSmb3QFpWsS0AmVE4medW5CJpiWYQrdIBZmLVreZh
         bmi3uk+J13MMfte4PprJu9rwQcGqXVU95Vwa6YNYQUMXGNMwjL40wv1hrWVc9RCVXt83
         GD70x9x92qO/7LMH1G59iU8H2gYy+pTnVZ34/Xe/PwYbHBqGaQPQoaQfDC+geDkSLF0X
         XXKQ==
X-Gm-Message-State: AOJu0YwJENOAlftUTLuQRqMOcVb+5LjvOka25DLJ23Qs2Pqy2ACMVy0O
        8i3NjTi6fBEpoHhC+b7TbTI3jmG2i1fYL0sUJyw0rivT5pue5yJybjoKoTFHg/uo1tx4PerfPNb
        aGMDAAus4aHUQlnw+Wb4tJ6OsyfGdT0WtsKz2TX467nQb1L0vKAWaBAlVrA==
X-Received: by 2002:a05:6102:24d:b0:44d:626b:94da with SMTP id a13-20020a056102024d00b0044d626b94damr7897839vsq.32.1695381501548;
        Fri, 22 Sep 2023 04:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECd8EeaqAfIOTvpZu2YbNzYrM6BT+Exh7ByejQWuxuzmBp6EbQZln1Ql6a1cLmCSI0wvZNFC0ZMF1t7Of9NDg=
X-Received: by 2002:a05:6102:24d:b0:44d:626b:94da with SMTP id
 a13-20020a056102024d00b0044d626b94damr7897831vsq.32.1695381501312; Fri, 22
 Sep 2023 04:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230921114940.957141-1-pbonzini@redhat.com> <169537583818.27769.18320521458994415527.tip-bot2@tip-bot2>
 <ZQ1rwSJsO7A4HR8O@gmail.com>
In-Reply-To: <ZQ1rwSJsO7A4HR8O@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 22 Sep 2023 13:18:09 +0200
Message-ID: <CABgObfbiO5Jm-S_1TVi-NdO4GxMsJeagaEHYEFBJ_6ABFdhicg@mail.gmail.com>
Subject: Re: [tip: x86/cpu] x86/cpu: Clear SVM feature if disabled by BIOS
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 22, 2023 at 12:26=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
> It's a bit sad that we are duplicating identical code.
> We are doing it in other cases as well: for example nearby_node() is
> duplicated between arch/x86/kernel/cpu/amd.c and
> arch/x86/kernel/cpu/hygon.c too.

It is sad, and yeah I looked at nearby_node() to see if that was neverthele=
ss
expected.

AMD and Hygon pretend that they are different, and use different families
for what is effectively the same processor, and that's silly. In fact back =
in
2018 (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1741155.=
html)
I complained that if AMD and Hygon are organizing the family numbers so
that there's never going to be a conflict, it makes no sense to have a
separate vendor at all.

Yes it's not a lot of code but sooner or later some change will be applied
only to amd.c, because honestly who even thinks of Hygon...

Paolo

